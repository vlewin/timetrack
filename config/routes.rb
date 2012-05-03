Timestamps::Application.routes.draw do
  resources :timetracks
  #match 'timetracks' => 'timetracks#index.js', :via => :get
  root :to => 'timetracks#index'
end

