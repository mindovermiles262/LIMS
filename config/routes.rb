Rails.application.routes.draw do
  
  
  devise_for :users, :controllers => { registrations: 'registrations' }
  get '/users/:id', to: 'users#show',   as: 'users_show'
  get '/users',     to: 'users#index',  as: 'users_index'

  root to: "static_pages#index"
  
  resources :test_methods
  # TODO: Limit Projects, tests
  resources :projects do
    collection do
      get 'add_form_field'
    end
  end
  resources :tests
  resources :batches
end
