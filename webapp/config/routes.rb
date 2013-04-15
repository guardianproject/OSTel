Devise::Application.routes.draw do
  root :to => 'home#index'
  get "users/suggest"
  get "users/link"

	#these symbols map to models
  devise_for :users, :admin

  #these symbols map to controllers
  match '/about' => 'home#about', :as => 'about'
  match '/privacy' => 'home#privacy', :as => 'privacy'

  # no admins yet. Devise makes them by default though.
  resources :admins, :only => :index
  resources :users, :only => [:show,:edit,:update,:destroy]
  match '/token' => 'home#token', :as => :token
end
