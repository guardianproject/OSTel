DeviseExample::Application.routes.draw do
	#these symbols map to models
  devise_for :users, :admin

	#these symbols map to controllers
  resources :home, :only => :index
  resources :admins, :only => :index

  root :to => 'home#index'

  match '/token' => 'home#token', :as => :token
end
