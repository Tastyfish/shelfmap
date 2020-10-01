Rails.application.routes.draw do
  post 'signup', controller: :signup, action: :create
  post 'refresh', controller: :refresh, action: :create
  post 'signin', controller: :signin, action: :create
  delete 'signin', controller: :signin, action: :destroy

  namespace :api do
    namespace :v1 do
      resources :shelves
      resources :products

      get 'site', controller: :site, action: :show
      patch 'site', controller: :site, action: :update
    end
  end

  match '*unmatched', to: 'application#route_not_found', via: :all
end
