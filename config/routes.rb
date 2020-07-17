Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :items
  # resources :credit_cards, only: [:index, :new, :pay]
  resources :credit_cards, only: [:index, :new, :create, :show, :destroy] do
  # resources :credit_cards, only: [:new, :create, :show, :destroy] do
    # collection do
    #   post 'pay', to: 'credit_cards#pay'
    # end
    collection do
      get 'buy'
      post 'pay'
    end
  end

  resources :items, only: [:index, :show, :new, :create]
  resources :categories, only: [:index]
  resources :item_imgs
  resources :users, only: [:show]
  resources :items do
    member do
      get 'category_children'
      get 'category_grandchildren'
    end
  end
end
