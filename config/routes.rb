Rails.application.routes.draw do

  root "public#index" # This is the default page - make it the index of the project
  resources :tasks
  
  # Default Route
  match ':controller(/:action(/:id))', :via => [:get, :post]
end
