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

  resources :products, only: [:index, :show] do
    member do
      get :find_or_create_chat_room
      resources :chat_rooms, only: [:index] do
        get :messages
      end
    end
  end

  resources :chat_rooms, only: "" do
    member do
      resources :messages
    end
  end

  root "home#index"
end
