Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: "devise/users/omniauth_callbacks",
    confirmations: 'devise/users/confirmations'
  }

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  mount ActionCable.server => '/cable'

  namespace :account do
    resources :products do
      member do
        patch :update_states
      end
    end

    resource :user, only: %i(edit update), path: ""
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

  resources :users, only: [:show]


  get '/about', to: "pages#about"

  root "home#index"
end
