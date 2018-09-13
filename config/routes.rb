Rails.application.routes.draw do

  get 'welcome/index'
  devise_for :users

  resources :users do
    resources :requests, only: [:show]
  end

  resources :requests do
    resources :availabilities, only: [:new, :update, :destroy]
  end

  get '/profile/:id', to: "profiles#show", as: 'profiles'
  # get '/profile', to: "profiles#index", as: 'profiles_index'

  root 'welcome#index'
end
