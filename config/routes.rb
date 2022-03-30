Rails.application.routes.draw do

  get "/404" => "errors#not_found"

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: 'merchant_items'
      end
      resources :items, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
