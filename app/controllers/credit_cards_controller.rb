class CreditCardsController < ApplicationController
  # require 'payjp'

  # def index
  # end

  # # def show
  #   # @card = Credit_card.find_by(params[:id])
  # # end

  # def new
  #   # card = Credit_card.where(user_id: current_user.id) # Credit_cardモデルのuser_idがcurrent_user.idのものを全て取得
  #   # redirect_to credit_card_path(@card.id) if credit_card.exists? #exists?はデータが存在するか？
  # end

  # def create #payjpとCardのデータベース作成
  #   Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
  #   #保管した顧客IDでpayjpから情報取得
  #   if params['payjp-token'].blank? # blank? nilまたは空のオブジェクトを判定できる。
  #     redirect_to action: 'new'
  #   else
  #     customer = Payjp::Customer.create(
  #       # description: 'test', # 無くてもOK。PAY.JPの顧客情報に表示する概要です。
  #       # email: current_user.email, # これも無くてOK
  #       credit_card: params['payjp-token'],
  #       # metadata: {user_id: current_user.id} # 無くてもOK
  #     ) 
  #     @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
  #     if @card.save
  #       redirect_to card_path(@card.id)
  #     else
  #       redirect_to action: 'create'
  #     end
  #   end
  # end

  # private

  # #user_idが外部キーとしてあるので、まずユーザーがないといけません。
  # def set_card
  #   @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  # end
  
  # # def destroy #PayjpとCardデータベースを削除
  # #   card = Card.find_by(user_id: current_user.id)
  # #   if card.blank?
  # #   else
  # #     Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
  # #     customer = Payjp::Customer.retrieve(card.customer_id)
  # #     customer.delete
  # #     card.delete
  # #   end
  # #     redirect_to new_card_path
  # # end

  # # def show #Cardのデータpayjpに送り情報を取り出す
  # #   card = Card.find_by(user_id: current_user.id)
  # #   if card.blank?
  # #     redirect_to new_card_path 
  # #   else
  # #     Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
  # #     customer = Payjp::Customer.retrieve(card.customer_id)
  # #     @default_card_information = customer.cards.retrieve(card.card_id)
  # #   end
  # # end

  # require 'payjp'

  # def index
  # end

  # def new
  #   card = Credit_card.where(user_id: current_user.id)
  #   redirect_to credit_card_path(current_user.id) if card.exists?
  # end


  # def pay #payjpとCardのデータベース作成
  #   Payjp.api_key = Rails.application.credentials[:pk_test_f9c4bb64158e5b8e9834ca5c]
  #   #保管した顧客IDでpayjpから情報取得
  #   if params['payjp-token'].blank?
  #     redirect_to new_card_path
  #   else
  #     customer = Payjp::Customer.create(
  #       card: params['payjp-token'],
  #       metadata: {user_id: current_user.id}
  #     ) 
  #     @card = Credit_card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
  #     if @card.save
  #       redirect_to credit_card_path(current_user.id)
  #     else
  #       redirect_to pay_credit_cards_path
  #     end
  #   end
  # end

  # def destroy #PayjpとCardデータベースを削除
  #   card = Credit_card.find_by(user_id: current_user.id)
  #   if card.blank?
  #   else
  #     Payjp.api_key = Rails.application.credentials[:pk_test_f9c4bb64158e5b8e9834ca5c]
  #     customer = Payjp::Customer.retrieve(card.customer_id)
  #     customer.delete
  #     card.delete
  #   end
  #     redirect_to new_credit_card_path
  # end

  # def show #Cardのデータpayjpに送り情報を取り出す
  #   card = Credit_card.find_by(user_id: current_user.id)
  #   if card.blank?
  #     redirect_to new_credit_card_path 
  #   else
  #     Payjp.api_key = Rails.application.credentials[:pk_test_f9c4bb64158e5b8e9834ca5c]
  #     customer = Payjp::Customer.retrieve(card.customer_id)
  #     @default_card_information = customer.cards.retrieve(card.card_id)
  #   end
  # end

  require "payjp" #PAYJPとやり取りするために、payjpをロード

  # def index
  # end

  def new
    # 後ほど、showアクション(登録クレジットカード詳細表示機能)実装時に追記します。
    # すでにクレジットカード登録されている場合は、showアクションにリダイレクト
    # @card = CreditCard.where(user_id: current_user.id)
    @card = CreditCard.where(user_id: 1)
    redirect_to credit_card_path(1) if @card.exists?
  end

  def create
    # 前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
    Payjp.api_key = Rails.application.credentials.dig(:PAYJP_PRIVATE_KEY)
    # Payjp.api_key = Rails.application.credentials[:pk_test_f9c4bb64158e5b8e9834ca5c]
    # 後ほどトークン作成処理を行いますが、そちらの完了の有無でフラッシュメッセージを表示させます。
    if params["payjp_token"].blank? # blank? nilまたは空のオブジェクトを判定できる。
      redirect_to action: "new", alert: "クレジットカードを登録できませんでした。"
    else
    # 無事トークン作成された場合のアクション(こっちが本命のアクション)
    # まずは生成したトークンから、顧客情報と紐付け、PAY.JP管理サイトに登録
      customer = Payjp::Customer.create(
        # email: current_user.email,
        email: 'a@a.com',
        card: params["payjp_token"]
        # metadata: {user_id: current_user.id} #最悪なくてもOK！
      )
      # 今度はトークン化した情報を自アプリのCredit_cardsテーブルに登録！
      # @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      @card = CreditCard.new(user_id: 1, customer_id: customer.id, card_id: customer.default_card)
      # @card = CreditCard.new
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
    # @card = CreditCard.find_by(user_id: current_user.id)
    @card = CreditCard.find_by(user_id: 1)
    if @card.blank?
      # 未登録なら新規登録画面に
      redirect_to action: "new" 
    else
      # 前前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
      Payjp.api_key = Rails.application.credentials.dig(:PAYJP_PRIVATE_KEY)
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
    # ログイン中のユーザーのクレジットカード登録の有無を判断
    # @card = CreditCard.find_by(user_id: current_user.id)
    @card = CreditCard.find_by(user_id: 1)
    if @card.blank?
      # 未登録なら新規登録画面に
      redirect_to action: "new"
    else
      # 前前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
      Payjp.api_key = Rails.application.credentials.dig(:PAYJP_PRIVATE_KEY)
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
        # redirect_to credit_card_path(current_user.id), alert: "削除できませんでした。"
        redirect_to credit_card_path(1), alert: "削除できませんでした。"
      end
    end
  end

  def index #元buy
    # 購入する商品を引っ張ってきます。
    # @item = Item.find(params[:item_id])
    @item = Item.find(1)
    # 商品ごとに複数枚写真を登録できるので、一応全部持ってきておきます。
    # @images = @item.images.all

    # まずはログインしているか確認
    # if user_signed_in?
    #   @user = current_user
      # クレジットカードが登録されているか確認
      # if @user.credit_card.present?
        # 前前前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
        # Payjp.api_key = Rails.application.credentials.dig(:PAYJP_PRIVATE_KEY)
        # ログインユーザーのクレジットカード情報を引っ張ってきます。
        # @card = CreditCard.find_by(user_id: current_user.id)
        # @card = CreditCard.find_by(user_id: 1)
        # (以下は以前のcredit_cardsコントローラーのshowアクションとほぼ一緒です)
        # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
        # customer = Payjp::Customer.retrieve(@card.customer_id)
        # カスタマー情報からカードの情報を引き出す
        # @customer_card = customer.cards.retrieve(@card.card_id)

        ##カードのアイコン表示のための定義づけ
        # @card_brand = @customer_card.brand
        # case @card_brand
        # when "Visa"
          # 例えば、Pay.jpからとってきたカード情報の、ブランドが"Visa"だった場合は返り値として
          # (画像として登録されている)Visa.pngを返す
        #   @card_src = "visa.jpeg"
        # when "JCB"
        #   @card_src = "jcb.jpeg"
        # when "MasterCard"
        #   @card_src = "master.png"
        # when "American Express"
        #   @card_src = "amex.jpeg"
        # when "Diners Club"
        #   @card_src = "diners.gif"
        # when "Discover"
        #   @card_src = "discover.gif"
        # end
        # viewの記述を簡略化
        ## 有効期限'月'を定義
        # @exp_month = @customer_card.exp_month.to_s
        ## 有効期限'年'を定義
      #   @exp_year = @customer_card.exp_year.to_s.slice(2,3)
      # else
      # end
    # else
      # ログインしていなければ、商品の購入ができずに、ログイン画面に移動します。
  #     redirect_to user_session_path, alert: "ログインしてください"
  #   end
  end

  def pay
    #ちなみに見やすさ考慮し、before_actionなどのリファクタリングなどはあえてしてません。
    # @item = Item.find(params[:item_id])
    @item = Item.find(1)
    # @images = @item.images.all

    # 購入テーブル登録ずみ商品は２重で購入されないようにする
    # (２重で決済されることを防ぐ)
    # if @item.purchase.present?
    if @item.id.present?
    # if @item.id.blank?
      # redirect_to product_path(@item.id), alert: "売り切れています。"
      flash.now[:alert] = '売り切れています'
      # redirect_to root_path, alert: "売り切れています。"
      redirect_to root_path
    else
      # 同時に2人が同時に購入し、二重で購入処理がされることを防ぐための記述
      @item.with_lock do
        # if current_user.credit_card.present?
        if current_user.card_id.present?
          # ログインユーザーがクレジットカード登録済みの場合の処理
          # ログインユーザーのクレジットカード情報を引っ張ってきます。
          # @card = CreditCard.find_by(user_id: current_user.id)
          @card = CreditCard.find_by(user_id: 1)
          # 前前前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
          Payjp.api_key = Rails.application.credentials.dig(:PAYJP_PRIVATE_KEY)
          #登録したカードでの、クレジットカード決済処理
          charge = Payjp::Charge.create(
          # 商品(product)の値段を引っ張ってきて決済金額(amount)に入れる
          amount: @item.price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
          )
        else
          # ログインユーザーがクレジットカード登録されていない場合(Checkout機能による処理を行います)
          # APIの「Checkout」ライブラリによる決済処理の記述
          Payjp::Charge.create(
          amount: @item.price,
          card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
          currency: 'jpy'
          )
        end
      #購入テーブルに登録処理(今回の実装では言及しませんが一応、、、)
      # @purchase = Purchase.create(buyer_id: current_user.id, product_id: params[:product_id])
      end
    end
  end

end
# amount: 809, # 決済する値段
        # card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
        # currency: 'jpy'