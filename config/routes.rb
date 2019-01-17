Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  
  devise_for :users

  resources :users do
    resources :requests, only: [:show, :index]
  end

  resources :requests do
    resources :availabilities, only: [:new, :update, :destroy]
    resources :comments, only: [:create, :destroy]
    member do
      patch :update_status
    end
  end

  get '/profile/:id', to: "profiles#show", as: 'profiles'

  root 'welcome#index'
end
