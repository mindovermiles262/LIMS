Rails.application.routes.draw do
  resources :test_methods, only: [:new, :create, :edit, :update, :index, :destroy]
  root "test_methods#index"
end
