# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'
  resources :movies, only: [:index]
  get 'movies/:title', to: 'movies#show'
end
