Rails.application.routes.draw do
  root 'welcome#index'

  namespace 'api' do
    namespace :v1 do

      namespace :merchants do
        get '/', to: 'merchants#index'
        get '/:id', to: 'merchants#show'
        get '/:id/items', to: 'items#index'
      end

    end
  end
end
