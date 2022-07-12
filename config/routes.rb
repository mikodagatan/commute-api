# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :v1 do # TODO: Change to v1 and folders and module names
    post '/auth/login', to: 'auth#login'
    resources :users, except: %i[new edit] do
      resource :profile, only: %i[create update]
    end
    namespace :transport do
      resources :companies
      resources :driver_profiles, path: 'drivers'
    end
  end
end
