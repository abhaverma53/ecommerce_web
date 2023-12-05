Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :vendors
  devise_for :users

  # resources :users, only: [:show]
  # resources :carts, only: [:show, :destroy]

  resources :products
  resources :vendors do
    resources :products, only: [:index, :new, :create]
  end

  resources :orders do
    collection do
      get 'user_orders'
      get 'placed_orders'
    end
  end

  root "products#index"
end
