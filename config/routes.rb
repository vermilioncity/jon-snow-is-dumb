Rails.application.routes.draw do
  root 'articles#index'
  get 'password_resets/new'
  get 'password_resets/edit'
  get '/about', to: 'static_pages#about'
  get '/projects', to: 'static_pages#projects'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  post '/edit', to: 'users#edit'

  resources :users, only: [:new, :create, :edit, :update, :index, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets, only:[:new, :create, :edit, :update]
  resources :articles

end

