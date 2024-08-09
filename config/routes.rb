# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
  root 'home#landing_page'

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
  get '/artists', to: redirect('/', status: :moved_permanently)
  resources :tagged_items
  resources :tags
  resources :activations
  resources :vendors
  get '/vendor_help', to: 'vendors#help'
  resources :uploads do
    member do
      patch :set_primary
      patch :set_menu
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
end
