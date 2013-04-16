Devise::Application.routes.draw do
  root :to => 'home#index'
  get "users/suggest"
  get "users/link"

	#these symbols map to models
  devise_for :users, :admin

  #these symbols map to controllers
  match '/about' => 'home#about', :as => 'about'
  match '/privacy' => 'home#privacy', :as => 'privacy'

  resources :users, :only => [:show,:edit,:update,:destroy]
  resources :admins, :only => :index
  match '/token' => 'home#token', :as => :token
end
