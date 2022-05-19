Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'api/v1/merchants/:id/items', to: 'api/v1/items#index'
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show] do
      end
      resources :merchants, only: [:index, :show] do
        resources :items, controller: 'merchants_items', action: :index
      end
    end
  end
end
