Rails.application.routes.draw do
  devise_for :users

  mount ActionCable.server => '/cable'

  namespace :account do
    resources :products
  end

  root "home#index"
end
