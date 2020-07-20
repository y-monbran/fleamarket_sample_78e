class CreditCardsController < ApplicationController
  require "payjp" #PAYJPとやり取りするために、payjpをロード
  before_action :set_item, only: [:buy, :pay]

  def new
    @card = CreditCard.where(user_id: current_user.id)
    redirect_to credit_card_path(current_user.id) if @card.exists?
  end

  def create
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
    if params["payjp_token"].blank? # blank? nilまたは空のオブジェクトを判定できる。
      redirect_to new_credit_card_path, alert: "クレジットカードを登録できませんでした。"
    else
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params["payjp_token"]
      )
      # 今度はトークン化した情報を自アプリのCredit_cardsテーブルに登録！
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      # 無事、トークン作成とともにcredit_cardsテーブルに登録された場合、createビューが表示されるように条件分岐
      if @card.save
        #もしcreateビューを作成しない場合はredirect_toなどで表示ビューを指定
      else
        redirect_to action: "create"
      end
    end
  end

  def show
    # ログイン中のユーザーのクレジットカード登録の有無を判断
    @card = CreditCard.find_by(user_id: current_user.id)
    if @card.blank?
      # 未登録なら新規登録画面に
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
      # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
      customer = Payjp::Customer.retrieve(@card.customer_id)
      # カスタマー情報からカードの情報を引き出す
      @customer_card = customer.cards.retrieve(@card.card_id)

      #カードのアイコン表示のための定義づけ
      @card_brand = @customer_card.brand
      case @card_brand
      when "Visa"
        @card_src = "visa.jpg"
      when "JCB"
        @card_src = "jcb.jpg"
      when "MasterCard"
        @card_src = "master.png"
      when "American Express"
        @card_src = "amex.jpg"
      end
      # 有効期限'月'を定義
      @exp_month = @customer_card.exp_month.to_s
      # 有効期限'年'を定義
      @exp_year = @customer_card.exp_year.to_s.slice(2,3)
    end
  end

  def destroy
    @card = CreditCard.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
      # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
      customer = Payjp::Customer.retrieve(@card.customer_id)
      # そのカスタマー情報を消す
      customer.delete
      @card.delete
      # 削除が完了しているか判断
      if @card.destroy
      # 削除完了していればdestroyのビューに移行
      else
        # 削除されなかった場合flashメッセージを表示させて、showのビューに移行
        redirect_to credit_card_path(current_user.id), alert: "削除できませんでした。"
      end
    end
  end

  def buy
    # 購入する商品を引っ張ってきます。
    @imgs = ItemImg.find(params[:id])
    # 商品ごとに複数枚写真を登録できるので、一応全部持ってきておきます。
    @item_imgs = @imgs.url
    # まずはログインしているか確認
    @add_cards = CreditCard.find_by(user_id: current_user.id)
    if user_signed_in?
     @user = current_user
      # クレジットカードが登録されているか確認
      if @user.credit_card.present?
        Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
        # ログインユーザーのクレジットカード情報を引っ張ってきます。
         @card = CreditCard.find_by(user_id: current_user.id)
        # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
         customer = Payjp::Customer.retrieve(@card.customer_id)
        # カスタマー情報からカードの情報を引き出す
         @customer_card = customer.cards.retrieve(@card.card_id)
        ##カードのアイコン表示のための定義づけ
         @card_brand = @customer_card.brand
         case @card_brand
         when "Visa"
          # 例えば、Pay.jpからとってきたカード情報の、ブランドが"Visa"だった場合は返り値として
          # (画像として登録されている)Visa.pngを返す
           @card_src = "visa.jpg"
           when "JCB"
           @card_src = "jcb.jpg"
           when "MasterCard"
           @card_src = "master.png"
           when "American Express"
           @card_src = "amex.jpg"
          end
        # viewの記述を簡略化
        ## 有効期限'月'を定義
        @exp_month = @customer_card.exp_month.to_s
        ## 有効期限'年'を定義
        @exp_year = @customer_card.exp_year.to_s.slice(2,3)
       else
       end
    else
      # ログインしていなければ、商品の購入ができずに、ログイン画面に移動します。
    redirect_to user_session_path, alert: "ログインしてください"
    end
  end

  def purchase_complite
  end


  def pay
    @imgs = ItemImg.find(params[:id])
    @item_imgs = @imgs.url
    @user = current_user
    if @user.credit_card.blank?
      redirect_to new_credit_card_path, alert: "購入にはクレジットカード登録が必要です"
    else
      card = current_user.credit_card
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
      Payjp::Charge.create(
      amount: @item.price,
      customer: card.customer_id,
      currency: 'jpy',
      )
      if @item.update(status: "sold", buyer_id: current_user.id)
        redirect_to purchase_complite_credit_cards_path, notice: "購入しました。"
      else
        redirect_to item_path, alert: "購入に失敗しました。"
      end
    end
  end

  
  private

  def set_item
    @item = Item.find(params[:id])
  end

end