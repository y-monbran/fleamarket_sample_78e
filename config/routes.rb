Rails.application.routes.draw do
  devise_for :items
  devise_for :users
  devise_scope :users do
    get '/users', to: redirect("/users/sign_up")
  end
  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items, only: [:index, :show, :new, :create, :destroy]
  destroyitems
  resources :items, only: [:index, :show, :destroy]
  resources :items, only: [:index, :show, :new, :create]
  resources :categories, only: [:index]
  resources :item_imgs
end
