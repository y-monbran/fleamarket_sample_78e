class CreditCardsController < ApplicationController
  def new
    card = Credit_card.where(user_id: current_user.id) # Credit_cardモデルのuser_idがcurrent_user.idのものを全て取得
    redirect_to credit_card_path(current_user.id) if credit_card.exists? #exists?はデータが存在するか？
  end

  def pay #payjpとCardのデータベース作成
    Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
    #保管した顧客IDでpayjpから情報取得
    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
      customer = Payjp::Customer.create(
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      ) 
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to card_path(current_user.id)
      else
        redirect_to pay_cards_path
      end
    end
  end
end
