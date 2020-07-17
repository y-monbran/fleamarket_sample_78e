class CreditCardsController < ApplicationController
  require "payjp" #PAYJPとやり取りするために、payjpをロード

  def new
    @card = CreditCard.where(user_id: current_user.id)
    redirect_to credit_card_path(current_user.id) if @card.exists?
  end

  def create
    # 前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
    # Payjp.api_key = Rails.application.credentials.dig(:PAYJP_PRIVATE_KEY)
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
    # 後ほどトークン作成処理を行いますが、そちらの完了の有無でフラッシュメッセージを表示させます。
    if params["payjp_token"].blank? # blank? nilまたは空のオブジェクトを判定できる。
      redirect_to action: "new", alert: "クレジットカードを登録できませんでした。"
    else
    # 無事トークン作成された場合のアクション(こっちが本命のアクション)
    # まずは生成したトークンから、顧客情報と紐付け、PAY.JP管理サイトに登録
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params["payjp_token"]
        # metadata: {user_id: current_user.id} #最悪なくてもOK！
      )
      # 今度はトークン化した情報を自アプリのCredit_cardsテーブルに登録！
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      # @card = CreditCard.new(user_id: 1, customer_id: customer.id, card_id: customer.default_card)
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
    # @card = CreditCard.find_by(user_id: 1)
    if @card.blank?
      # 未登録なら新規登録画面に
      redirect_to action: "new" 
    else
      # 前前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
      # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
      customer = Payjp::Customer.retrieve(@card.customer_id)
      # カスタマー情報からカードの情報を引き出す
      @customer_card = customer.cards.retrieve(@card.card_id)

      #カードのアイコン表示のための定義づけ
      @card_brand = @customer_card.brand
      case @card_brand
      when "Visa"
        # 例えば、Pay.jpからとってきたカード情報の、ブランドが"Visa"だった場合は返り値として
        # (画像として登録されている)Visa.pngを返す
        @card_src = "visa.jpeg"
      when "JCB"
        @card_src = "jcb.jpg"
      when "MasterCard"
        @card_src = "master.png"
      when "American Express"
        @card_src = "amex.jpeg"
      # when "Diners Club"
      #   @card_src = "diners.png"
      # when "Discover"
      #   @card_src = "discover.png"
      end

      #  viewの記述を簡略化
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
      # 前前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
      # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
      customer = Payjp::Customer.retrieve(@card.customer_id)
      # そのカスタマー情報を消す
      customer.delete
      @card.delete
      # 削除が完了しているか判断
      if @card.destroy
      # 削除完了していればdestroyのビューに移行
      # destroyビューを作るのが面倒であれば、flashメッセージを入れてトップページやマイページに飛ばしてもOK

      else
        # 削除されなかった場合flashメッセージを表示させて、showのビューに移行
        redirect_to credit_card_path(current_user.id), alert: "削除できませんでした。"
        # redirect_to credit_card_path(1), alert: "削除できませんでした。"
      end
    end
  end

  def index
    # 購入する商品を引っ張ってきます。
    @item = Item.find_by(params[:item_id])
    @imgs = ItemImg.find_by(params[:id])

    # @item = Item.find(1)
    # 商品ごとに複数枚写真を登録できるので、一応全部持ってきておきます。
    @item_imgs = @imgs.url

    # まずはログインしているか確認
    if user_signed_in?
     @user = current_user
      # クレジットカードが登録されているか確認
      if @user.credit_card.present?
        # 前前前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
        Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
        # ログインユーザーのクレジットカード情報を引っ張ってきます。
         @card = CreditCard.find_by(user_id: current_user.id)
        # (以下は以前のcredit_cardsコントローラーのshowアクションとほぼ一緒です)
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
           @card_src = "visa.jpeg"
           when "JCB"
           @card_src = "jcb.jpeg"
           when "MasterCard"
           @card_src = "master.png"
           when "American Express"
           @card_src = "amex.jpeg"
        # when "Diners Club"
        #   @card_src = "diners.gif"
        # when "Discover"
        #   @card_src = "discover.gif"
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

  def pay
    # @item = Item.find(params[:item_id])
    # @images = @item.images.all
    @item = Item.find_by(params[:item_id])
    @imgs = ItemImg.find_by(params[:id])
    @item_imgs = @imgs.url
    # 購入テーブル登録ずみ商品は２重で購入されないようにする
    # (２重で決済されることを防ぐ)
    # if @item.purchase.present?
    @user = current_user
    if @user.credit_card.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
      @item = Item.find_by(params[:item_id])
     # 購入した際の情報を元に引っ張ってくる
      card = current_user.credit_card
     # テーブル紐付けてるのでログインユーザーのクレジットカードを引っ張ってくる
      # Payjp.api_key = "sk_test_0e2eb234eabf724bfaa4e676"
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_PRIVATE_KEY)
     # キーをセットする(環境変数においても良い)
      Payjp::Charge.create(
      amount: @item.price, #支払金額
      customer: card.customer_id, #顧客ID
      currency: 'jpy', #日本円
      )
     # ↑商品の金額をamountへ、cardの顧客idをcustomerへ、currencyをjpyへ入れる
      # if @item.update(status: 1, buyer_id: current_user.id)
      #   flash[:notice] = '購入しました。'
      #   redirect_to controller: "products", action: 'show'
      # else
      #   flash[:alert] = '購入に失敗しました。'
      #   redirect_to controller: "products", action: 'show'
      # end
     #↑この辺はこちら側のテーブル設計どうりに色々しています
    end

  end

end