Rails.application.routes.draw do
  root 'tasks#index'

  resources :tasks, only: [:new, :create, :index] do
    resources :task_sessions, only: [:start, :stop] do
      post :start, on: :collection
      put  :stop, on: :member
    end
  end
end
