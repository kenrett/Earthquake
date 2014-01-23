Earthquakes2::Application.routes.draw do
  resources :earthquakes, :only => :index
end
