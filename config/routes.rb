Rails.application.routes.draw do
  devise_for :users
  root "dashboard#index"

  resources :projects, only: [ :new, :create, :edit, :update ]
  resources :projects, only: [] do
    resources :tasks, only: [ :new, :create, :edit, :update, :destroy ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
