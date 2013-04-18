Devise::Application.routes.draw do
  root :to => 'home#index'
  #these symbols map to models
  devise_for :users
  scope '/admin' do
    resources :users
    get "users/link"
    post "users/suggest"
  end


  #these symbols map to controllers
  match '/about' => 'home#about', :as => 'about'
  match '/privacy' => 'home#privacy', :as => 'privacy'
  match '/token' => 'home#token', :as => :token
end
