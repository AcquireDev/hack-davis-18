Rails.application.routes.draw do
  resources :applications
  resources :listings
  resources :companies
  post '/authenticate', to: "sessions#create"
  resources :users, only: [:create, :index, :update, :destroy]
  get '/current_user', to: 'users#show'
end
