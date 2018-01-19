Rails.application.routes.draw do
  root "static_pages#home"
  get "/home", to: "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/contact", to: "static_pages#contact"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/error", to: "static_pages#error"
  resources :events do
    resources :comments
  end
  resources :users

  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  namespace :admin do
    resources :users, concerns: :paginatable
  end

end
