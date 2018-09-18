Rails.application.routes.draw do

  devise_for :users

  resources :users do
    resources :requests, only: [:show, :index]
  end

  resources :requests do
    resources :availabilities, only: [:new, :update, :destroy]
  end

  get '/profile/:id', to: "profiles#show", as: 'profiles'

  root 'welcome#index'
end
