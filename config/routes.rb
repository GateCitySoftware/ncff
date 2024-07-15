# frozen_string_literal: true

Rails.application.routes.draw do
  resources :external_links
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/auth', to: 'sessions#auth'
  delete '/logout', to: 'sessions#destroy'

  resources :schedules
  resources :performances
  resources :stages
  resources :artists
  resources :uploads
  resources :tagged_items
  resources :tags
  resources :activation
  resources :merchant
  resources :vendor

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
