# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  root 'home#index'
  get '/gcs_landing_page', to: 'home#gcs_landing_page'
  get '/landing_conference_example', to: 'home#landing_conference_example'
  get '/v3', to: 'home#index_v3'
  get '/list_view', to: 'home#list_view'
  get '/item_view', to: 'home#item_view'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/auth', to: 'sessions#auth'
  delete '/logout', to: 'sessions#destroy'
  resources :favorites
  resources :stage_schedules
  resources :embedded_contents
  resources :external_links
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
