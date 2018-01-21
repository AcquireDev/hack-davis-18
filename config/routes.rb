Rails.application.routes.draw do
  post '/authenticate', to: "sessions#create"
  resources :users, only: [:create, :index, :update, :destroy]
  get '/current_user', to: 'users#show'
end
