Devise::Application.routes.draw do
	#these symbols map to models
  devise_for :users, :admin

  #these symbols map to controllers
  match '/about' => 'home#about', :as => 'about'
  match '/privacy' => 'home#privacy', :as => 'privacy'
  root :to => 'home#index'

  # no admins yet. Devise makes them by default though.
  resources :admins, :only => :index


  match '/token' => 'home#token', :as => :token
end
