Rails.application.routes.draw do
  root 'welcome#index'

  namespace 'api' do
    namespace :v1 do

      namespace :merchants do
        get '/', to: 'merchants#index'
        get '/most_revenue', to: 'business#most_revenue'
        get '/:id', to: 'merchants#show'
        get '/:id/items', to: 'items#index'
      end

      namespace :items do
        get '/', to: 'items#index'
        get '/:id', to: 'items#show'
        get '/:id/merchants', to: 'merchants#show'
      end

      resources :merchants, only: :index
    end
  end
end
