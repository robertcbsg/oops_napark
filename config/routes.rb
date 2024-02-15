# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    namespace :v1 do
      resources :clock, only: [:index]
      resources :park, only: [:create]

      namespace :parking do
        resources :entry_points, only: [:index, :show, :create]
        resources :slots, only: [:index, :show, :create, :edit]
      end
    end
  end

  get '*path', to: 'home#index', via: :all # redirect all routes not defined in api, back to index page

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
