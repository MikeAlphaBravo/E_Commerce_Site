Rails.application.routes.draw do
  root 'pages#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :order_items
  resources :orders
  resources :products
  resources :accounts
  resource :cart, only: [:show]
end
