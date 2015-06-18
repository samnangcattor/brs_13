Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  resources :users
  devise_for :admins,
    class_name: "User",
    controllers: {sessions: "admins/sessions"},
    only: :sessions
  namespace :admins do
    root "users#index"
    devise_for :users
    resources :users
  end
end
