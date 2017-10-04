Rails.application.routes.draw do
  
  
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users

  root to: "static_pages#index"
  
  resources :test_methods
  resources :projects
  resources :tests, only: [:update, :destroy]
  resources :batches do
    get '/add/:id', to: 'batches#add', as: 'add_test'
    get '/results', to: 'batches#results', as: 'results'
  end
  resources :pipets
end
