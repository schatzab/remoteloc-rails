Rails.application.routes.draw do

  root "public#index" # This is the default page - make it the index of the project
  resources :tasks

  #get 'city/:permalink', :to => 'public#city' 
  # any time we have a URL of city with some type of permalink, we want to route that to public/city
  #get 'state/:name', :to => 'public#state' 
  # any time we have a URL of state with some type of state name, we want to route that to public/state
  #get 'admin', :to => "access#index"
  
  # Default Route
  match ':controller(/:action(/:id))', :via => [:get, :post]
end