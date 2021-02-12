Rails.application.routes.draw do
  root 'welcome#index'

  namespace 'api' do
    namespace :v1 do

      namespace :merchants do
        get '/find_all', to: 'find#index'
        get '/merchants', to: 'merchants#index'
      end

    end
  end
end
