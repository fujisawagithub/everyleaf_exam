Rails.application.routes.draw do
  root to: 'users#new'
  resources :tasks
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resource :users
  end
end
