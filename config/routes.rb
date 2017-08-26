Rails.application.routes.draw do
  resources :test_methods, only: [:new, :create, :index, :edit, :destory]
end
