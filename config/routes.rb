Rails.application.routes.draw do
  root "tops#index"

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create show edit update]
  resources :post_icons
  resources :created_icons, only: %i[new create show destroy]
  resources :icons, only: %i[index]
end
