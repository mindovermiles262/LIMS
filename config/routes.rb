Rails.application.routes.draw do
  devise_for :analyst
  devise_for :admin
  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: "static_pages#index"
  
  resources :test_methods, only: [:new, :create, :edit, :update, :index, :destroy]
end
