Rails.application.routes.draw do
  root "static_pages#index"
  
  resources :test_methods, only: [:new, :create, :edit, :update, :index, :destroy]
end
