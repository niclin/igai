Rails.application.routes.draw do
  devise_for :users

  mount ActionCable.server => '/cable'

  namespace :account do
    resources :products
  end

  resources :products, only: [:index, :show] do
    member do
      get :find_or_create_chat_room
    end
  end

  resources :chat_rooms, only: [:index] do
    member do
      get :messages

      resources :messages, only: "" do
        collection do
          post :read
        end
      end
    end
  end

  root "home#index"
end
