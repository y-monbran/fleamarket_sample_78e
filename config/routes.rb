Rails.application.routes.draw do
  devise_for :users
  devise_scope :users do
    get '/users', to: redirect("/users/sign_up")
  end
  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items, only: [:index, :show, :new, :create] do
    collection do
      post 'buy'
    end
  end
  # resources :items
  # resources :credit_cards, only: [:index, :new, :pay]
  resources :credit_cards, only: [:index, :new, :create, :show, :destroy] do
    # collection do
    #   post 'pay', to: 'credit_cards#pay'
    # end
  end
  resources :categories, only: [:index]
  resources :item_imgs
  resources :users, only: [:index] # お試し
end
