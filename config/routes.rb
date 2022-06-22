Rails.application.routes.draw do
  resources :buckets
  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  #  root "tasks#index"
   root "buckets#index"
end
