Timestamps::Application.routes.draw do
  devise_for :users

  resources :timetracks do
    match 'timetracks' => "timtracks#update", :via => :put
  end
  root :to => 'timetracks#index'
end
