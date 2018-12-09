Rails.application.routes.draw do
  devise_for :users

  mount ActionCable.server => '/cable'

  namespace :account do
    resources :products
  end

  resources :products, only: [:index, :show]

  root "home#index"
end
