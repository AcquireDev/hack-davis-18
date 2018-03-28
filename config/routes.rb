Rails.application.routes.draw do
  resources :applications
  resources :listings
  resources :companies
  post '/authenticate', to: "sessions#create"
  resources :users, only: [:create, :index, :update, :destroy]
  get '/current_user', to: 'users#show'
  get '/job_boards', to: 'job_boards#index'
  patch '/user_preferences/set_job_board', to: 'user#set_board_id'
end
