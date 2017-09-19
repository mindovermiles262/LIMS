Rails.application.routes.draw do
  
  
  devise_for :users, :controllers => { registrations: 'registrations' }
  get '/users/:id',     to: 'users#show',     as: 'users_show'
  get '/users',         to: 'users#index',    as: 'users_index'
  delete '/users/:id',  to: 'users#destroy',  as: 'users_destroy'

  root to: "static_pages#index"
  
  resources :test_methods
  resources :projects
  resources :tests, only: [:update, :destroy]
  resources :batches
end
