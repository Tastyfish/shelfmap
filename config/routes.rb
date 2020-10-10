Rails.application.routes.draw do
  devise_for :users,
    path: 'user/v1',
    controllers: {
      registrations: 'user/v1/registrations',
      sessions: 'user/v1/sessions'
    },
    defaults: { format: :json }

  namespace :api do
    namespace :v1 do
      resources :shelves
      resources :products

      get 'site', controller: :site, action: :show
      patch 'site', controller: :site, action: :update

      get 'user', controller: :user, action: :show
    end
  end

  match '*unmatched', to: 'application#route_not_found', via: :all
end
