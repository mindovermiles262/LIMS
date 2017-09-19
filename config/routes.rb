Rails.application.routes.draw do
  
  
  devise_for :users, :controllers => { registrations: 'registrations' }
  get '/users/:id', to: 'users#show',   as: 'users_show'
  get '/users',     to: 'users#index',  as: 'users_index'

  root to: "static_pages#index"
  
  resources :test_methods
  # TODO: Limit Projects, tests
  resources :projects
  resources :tests
  resources :batches
end
