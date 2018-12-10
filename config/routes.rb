Rails.application.routes.draw do
  devise_for :users

  mount ActionCable.server => '/cable'

  namespace :account do
    resources :products do
      member do
        delete 'pictures/:picture_id' => 'products#destroy_picture', as: :desctroy
      end
    end
  end

  resources :products, only: [:index, :show]

  root "home#index"
end
