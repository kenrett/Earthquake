Earthquakes2::Application.routes.draw do
  # root to: 'earthquakes#index', :as => "earthquake"
  resources :earthquakes, :only => :index
end
