Devise::Application.routes.draw do
  root :to => 'home#index'
  #these symbols map to models
  devise_for :users do
    get 'users', :to => 'users#show', :as => :user_root
  end
  scope '/admin' do
    resources :users
    get "users/link", {:controller => "users", :action => "link"}
    post "users/suggest", {:controller => "users", :action => "suggest"}
  end


  #these symbols map to controllers
  match '/about' => 'home#about', :as => 'about'
  match '/faq' => 'home#faq', :as => 'faq'
  match '/privacy' => 'home#privacy', :as => 'privacy'
  match '/token' => 'home#token', :as => :token
end
