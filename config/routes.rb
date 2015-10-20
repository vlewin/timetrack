Timetracker::Application.routes.draw do
  root 'timetracks#index'

  resources :timetracks
  resources :absences

  devise_for :users
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_out', to: 'devise/sessions#destroy'
  end
end
