Timestamps::Application.routes.draw do
  authenticated :user do
    root :to => 'timetracks#index'
  end

  root :to => 'timetracks#index'
  devise_for :users

  resources :timetracks
  resources :users, :only => [:show, :index]

#  resources :timetracks do
#    match 'timetracks' => "timtracks#update", :via => :put
#  end

end
