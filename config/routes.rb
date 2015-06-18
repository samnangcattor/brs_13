Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  resources :users
  get "users/:id/:status", to: "relationships#index", as: :users_with_status
  devise_for :admins,
    class_name: "User",
    controllers: {sessions: "admins/sessions", only: [:create]},
    only: :sessions
  namespace :admins do
    root "users#index"
    devise_for :users, only: [:create, :show, :destroy]
    resources :users
  end
  resources :relationships, only: [:index, :create, :destroy]
end
