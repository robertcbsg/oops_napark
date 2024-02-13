Rails.application.routes.draw do
  # get 'home/index'
  root 'home#index'    # [RDC] map requests to '/' to the index action of the home controller

  namespace :api do
    resources :clock
  end

  get '*path', to: 'home#index', via: :all     # redirect all routes not defined in api, back to index page

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
