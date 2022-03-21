Rails.application.routes.draw do
  root to: 'catalog/search#index'

  namespace :catalog do
    get 'search/', to: 'search#index'

    namespace :marc do
      namespace :record do
        get 'import/new'
        post 'import/create'
      end

      resources :records
    end
  end

  mount MaterialViewComponents::Engine => '/material_view_components'

  require 'sidekiq/web'

  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
end
