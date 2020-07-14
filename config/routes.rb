Rails.application.routes.draw do
  devise_for :users
  devise_scope :users do
    get '/users', to: redirect("/users/sign_up")
  end
  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items, only: [:index, :show, :new, :create]
  resources :categories, only: [:index]
  resources :item_imgs
  
  resources :items do
    member do
      get 'category_children'
      get 'category_grandchildren'
    end
  end
end
