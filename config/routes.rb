Timestamps::Application.routes.draw do
  devise_for :users

  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
    get "sign_out", :to => "devise/sessions#destroy"
  end

  resources :playgrounds
  resources :playground
  resources :timetracks

  root :to => 'timetracks#index'
end
