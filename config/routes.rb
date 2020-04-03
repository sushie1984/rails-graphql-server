Rails.application.routes.draw do
  root 'currencies#index'
  namespace :api do
    post "/graphql", to: "graphql#execute"
  end
end
