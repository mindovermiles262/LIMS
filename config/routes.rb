Rails.application.routes.draw do
  devise_for :analyst
  devise_for :admin
  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: "static_pages#index"
  
  resources :test_methods
  # TODO: Limit Projects
  resources :projects 
end
