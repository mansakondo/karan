Rails.application.routes.draw do
  namespace :catalog do
    namespace :marc do
      resources :records
    end
  end
end
