Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "merchants/find", to: 'search#index'
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: 'merchant_items'
      end
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, only: [:index]
      end
    end
  end
end
