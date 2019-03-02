Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  # scope module: 'organizations', path: 'o'  do
  resources :organizations do
    resources :teams,       only: :show
  end

  resources :teams,         except: [:show, :index]
  resources :organizations, only: :show

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

  #CHART routes
  namespace :charts do
    get 'get_requests_for_user'
  end

  get '/profile/:id', to: "profiles#show", as: 'profiles'

  root 'welcome#index'
end
