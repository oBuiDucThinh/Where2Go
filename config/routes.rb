Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  get "/home", to: "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/contact", to: "static_pages#contact"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/error", to: "static_pages#error"
  resources :events do
    collection do
      match "search" => "events#search", via: [:get, :post], as: :search
    end
    resources :comments, :like_events, :join_events
  end

  resources :users, only: [:show, :edit, :update]

  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  namespace :admin do
    root "statistics#index"
    resources :statistics
    resources :users, :events, concerns: :paginatable
  end

end
