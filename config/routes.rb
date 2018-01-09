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
    resources :comments
    collection do
      match "search" => "events#search", via: [:get, :post], as: :search
    end
  end
  resources :users

  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end

  namespace :admin do
    root "statistics#index"
    resources :users, concerns: :paginatable
    resources :statistics
  end

end
