Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :requests do
    resources :availabilities, only: [:new, :update, :destroy]
  end

  get "new", to: "requests#new"

  root 'requests#index'
end
