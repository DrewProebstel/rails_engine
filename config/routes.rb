Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'api/v1/merchants/:id/items', to: 'api/v1/items#index'
  get '/api/v1/items/:id/merchant', to: 'api/v1/items_merchants#index'
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show, :create, :update] do
        resources :merchants, controller: 'items_merchants', action: :index
      end
      resources :merchants, only: [:index, :show] do
        resources :items, controller: 'merchants_items', action: :index
      end
    end
  end
end
