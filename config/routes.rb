Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'events#index'

  resources :events, only: [:index, :new, :create, :show] do
    post 'attend', on: :member
  end
  resources :users, only: [:show]
  resources :attendances, only: [:create, :destroy]


end
