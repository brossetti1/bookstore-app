Rails.application.routes.draw do
  root to: "catalogs#index"

  get '/signup', to: 'users#new', as: 'signup'
  get '/signin', to: 'sessions#new', as: 'signin'
  post '/signin', to: 'sessions#create'
  get '/add_publisher', to: 'publishers#new', as: 'add_publisher'

  resources :authors
  resources :books
  resources :users, only: [:index, :show, :new, :create]
  resource :session
  resources :publishers, except: [:new]

end
