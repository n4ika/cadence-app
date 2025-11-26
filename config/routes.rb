Rails.application.routes.draw do
  devise_for :users
  root "dashboard#index"

  resources :projects, only: [ :new, :create, :edit, :update ] do
    resources :tasks, only: [ :new, :create, :edit, :update, :destroy ]
  end
  get 'notifications/recent', to: 'notifications#recent', as: 'recent_notifications'
  get 'notifications/unread_count', to: 'notifications#unread_count', as: 'unread_notifications_count'
  
  get "up" => "rails/health#show", as: :rails_health_check
end
