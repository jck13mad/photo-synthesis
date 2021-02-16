Rails.application.routes.draw do
  root 'sessions#welcome'

  get '/auth/:provider/callback', to: 'sessions#omniauth'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/users/:id', to: 'users#show', as: 'user'

  resources :types, only: [:new, :create, :index, :show] do
    resources :plants, only: [:new, :create, :index]
  end 
  resources :comments
  resources :users
  resources :plants do 
    resources :comments
  end 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
