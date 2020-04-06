# frozen_string_literal: true

Rails.application.routes.draw do
  root 'currencies#index'

  resources :currencies, only: %i[index show exchange] do
    member do
      get 'exchange'
    end
  end

  namespace :api do
    post '/graphql', to: 'graphql#execute'
  end
end
