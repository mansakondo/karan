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
end
