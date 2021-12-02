Rails.application.routes.draw do
  root to: 'tasks#new'
  resources :tasks
end
