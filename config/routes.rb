# frozen_string_literal: true

Rails.application.routes.draw do
  root "artists#index"

  resources :stage_schedules
  resources :embedded_contents
  resources :external_links
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/auth', to: 'sessions#auth'
  delete '/logout', to: 'sessions#destroy'

  resources :schedules
  resources :performances
  resources :stages
  resources :artists
  resources :tagged_items
  resources :tags
  resources :activations
  resources :vendors
  resources :uploads do
    member do
      patch :set_primary
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
end
