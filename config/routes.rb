Rails.application.routes.draw do
  devise_for :users

  mount ActionCable.server => '/cable'

  root "home#index"
end
