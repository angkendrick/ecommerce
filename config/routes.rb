Rails.application.routes.draw do
  resources :orders
  devise_for :users
  resources :listings do
    resources :orders
  end

  get 'pages/about'
  get 'pages/contact'
  get 'seller', to: 'listings#seller'

  root 'listings#index'


end
