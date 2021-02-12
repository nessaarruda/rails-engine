Rails.application.routes.draw do
  root 'welcome#index'

  namespace 'api' do
    namespace :v1 do

      namespace :merchants do
        get '/find_all', to: 'find#index'
        get '/merchants', to: 'merchants#index'
        get '/merchants/:id', to: 'merchants#show'
        get '/merchants/:id/items', to: 'items#index'
      end

    end
  end
end
