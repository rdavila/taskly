Rails.application.routes.draw do
  root 'tasks#index'

  resources :tasks, only: [:new, :create, :index]
end
