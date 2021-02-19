Rails.application.routes.draw do
  root 'welcome#index'

  namespace 'api' do
    namespace :v1 do

      namespace :merchants do
        get '/most_items', to: 'search#most_items'
        get '/', to: 'merchants#index'
        get '/find', to: 'search#find_merchant'
        get '/:id', to: 'merchants#show'
        get '/:id/items', to: 'items#index'
      end

      namespace :revenue do
        get '/', to: 'merchants/business#revenue_date_range'
        namespace :merchants do
          get '/', to: 'business#most_revenue'
          get '/:id', to: 'business#total_revenue'
        end
      end

      namespace :items do
        get '/find_all', to: 'search#find_items'
        get '/', to: 'items#index'
        post '/', to: 'items#create'
        get '/:id', to: 'items#show'
        delete '/:id', to: 'items#destroy'
        put '/:id', to: 'items#update'
        get '/:id/merchant', to: 'merchants#show'
      end

      resources :merchants, only: :index
    end
  end
end
