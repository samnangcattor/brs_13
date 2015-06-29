Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  resources :users, only: [:index, :show] do
    resources :request_books
  end
  get "users/:id/:status", to: "relationships#index", as: :users_with_status
  resources :books, only: [:index, :show]
  resources :authors, only: [:show]
  resources :categories, only: [:show, :index]
  devise_for :admins,
    class_name: "User",
    controllers: {sessions: "admins/sessions", only: [:create]},
    only: :sessions
  namespace :admins do
    root "users#index"
    devise_for :users
    resources :users
    resources :books
    resources :authors
    resources :categories
    resources :reviews, only: [:show]
    resources :request_books, only: [:index, :destroy]
  end
  resources :relationships, only: [:index, :create, :destroy]
  resources :reviews, except: [:index]
  resources :comments, except: [:index, :show]
  resources :book_states, only: [:create, :update]
  resources :book_favorites, only: [:index, :create, :destroy]
  resources :request_books, except: [:show, :edit]
end
