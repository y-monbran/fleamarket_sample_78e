 Rails.application.routes.draw do
    devise_for :users, controllers: {
      registrations: 'users/registrations'
    }
    devise_scope :user do
      get 'addresses', to: 'users/registrations#new_address'
      post 'addresses', to: 'users/registrations#create_address'
    end
    
    root 'items#index'

    resources :items, only: [:index, :show, :new, :create]
    resources :categories, only: [:index]
    resources :item_imgs
    resources :users, only: [:index]
 end
