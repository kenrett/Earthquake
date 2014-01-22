Earthquakes2::Application.routes.draw do
  
  # NEED TO FIX THIS FOR HEROKU
  resources :earthquakes, :only => :index
end
