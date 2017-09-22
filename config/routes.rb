Rails.application.routes.draw do
  
  
  devise_for :users, :controllers => { registrations: 'registrations' }
  get '/users/:id',     to: 'users#show',     as: 'users_show'
  get '/users',         to: 'users#index',    as: 'users_index'
  get '/users/:id/edit', to: 'users#edit',    as: 'edit_user'
  delete '/users/:id',  to: 'users#destroy',  as: 'users_destroy'

  root to: "static_pages#index"
  
  resources :test_methods
  resources :projects
  resources :tests, only: [:update, :destroy]
  resources :batches do
    get '/add/:id', to: 'batches#add', as: 'add_test'
  end
end
