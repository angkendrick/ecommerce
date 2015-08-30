Rails.application.routes.draw do
  devise_for :users
  resources :listings

  get 'pages/about'
  get 'pages/contact'
  get 'seller', to: 'listings#seller'

  root 'listings#index'


end
