Rails.application.routes.draw do
  root "static_pages#home"
  get "/signup", to: "users#new"
  get "/home", to: "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/contact", to: "static_pages#contact"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/events", to: "events#index"
  get "/contact", to: "static_pages#contact"

  resources :events
  resources :users
end
