Rails.application.routes.draw do
  namespace :catalog do
    namespace :marc do
      namespace :record do
        get 'import/new'
        get 'import/create'
      end
      resources :records
    end
  end
end
