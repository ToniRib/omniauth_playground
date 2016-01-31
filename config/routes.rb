Rails.application.routes.draw do
  get "/auth/:provider/callback", to: "sessions#create"
  resources :sessions, only: [:new, :create]
  get "/dashboard", to: "users#show"
  resources :workouts, only: [:index, :create]
end
