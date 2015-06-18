Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  resources :users
  devise_for :admins,
    class_name: "User",
    controller: {sessions: "admins/sessions"},
    only: :sessions
  namespace :admins do
    root "users#index"
    resources :users
  end
end
