Rails.application.routes.draw do
  devise_for :items
  devise_for :users
  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items, only: [:index, :show, :destroy]
  resources :categories, only: [:index]
end
