Devise::Application.routes.draw do
  root :to => 'home#index'
  #these symbols map to models
  devise_for :users

  scope '/manage' do
    resources :users
    get "users/link", {:controller => "users", :action => "link"}
    post "users/suggest", {:controller => "users", :action => "suggest"}
    get "user/aliases", {:controller => "users", :action => "aliases"}
  end


  #these symbols map to controllers
  match '/about' => 'home#about', :as => 'about'
  match '/privacy' => 'home#privacy', :as => 'privacy'
  match '/token' => 'home#token', :as => :token
end
