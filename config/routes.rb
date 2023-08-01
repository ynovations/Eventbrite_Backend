Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'events#index'

  resources :events, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    post 'attend', on: :member
    get 'invite', on: :member
    patch 'send_invitations', on: :member
  end
  resources :users, only: [:show]

  resources :attendances, only: [:create, :destroy]
  delete 'remove_attendance/:id', to: 'attendances#remove_attendance', as: 'remove_attendance'


end
