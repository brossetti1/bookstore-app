Rails.application.routes.draw do
  root to: "catalogs#index"

  resources :authors
  resources :books
  resources :users, only: [:index, :show, :new, :create]
end
