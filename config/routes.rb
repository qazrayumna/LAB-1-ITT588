Rails.application.routes.draw do
  root "sessions#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"

  get "/home", to: "home#index"
  delete "/logout", to: "sessions#destroy"
end
