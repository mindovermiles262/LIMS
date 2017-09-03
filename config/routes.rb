Rails.application.routes.draw do
  devise_for :analyst
  devise_for :admin
  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: "static_pages#index"
  
  resources :test_methods
  # TODO: Limit Projects, tests
  resources :projects 
  resources :tests
end
