Timestamps::Application.routes.draw do
  devise_for :users

  resources :timetracks
  root :to => 'timetracks#index'
end
