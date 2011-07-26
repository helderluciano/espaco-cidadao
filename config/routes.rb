Blog::Application.routes.draw do

  resources :helps

  resources :microposts do
	resources :comentarios
  end

  resources :coments

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :users

  resources :sessions, :only => [:new, :create, :destroy]

  resources :microposts, :only => [:create, :destroy, :show]

  resources :relationships, :only => [:create, :destroy]

  get "sessions/new"

  get "users/new"

  match '/signup',  :to => 'users#new'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'

  root :to => 'pages#home'

  get "pages/home"

  get "pages/contact"

  
  

  


end

 
  

  
