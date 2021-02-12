Rails.application.routes.draw do
  root 'welcome#index'

  namespace 'api' do
    namespace :v1 do

      namespace :merchants do
        get '/merchants', to: 'api/v1/merchants/merchants_controller#index'
      end

    end
  end
end
