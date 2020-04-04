Rails.application.routes.draw do
  root 'currencies#index'

  resources :currencies, only: [:index, :show, :exchange] do
    member do
      get 'exchange'
    end
  end

  namespace :api do
    post "/graphql", to: "graphql#execute"
  end
end
