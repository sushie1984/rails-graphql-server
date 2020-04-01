Rails.application.routes.draw do
  root 'currency#index'
  namespace :api do
    post "/graphql", to: "graphql#execute"
  end
end
