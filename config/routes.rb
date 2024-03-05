Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root "tops#index"

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create show edit update]
  resources :post_icons
  resources :created_icons do
    collection do
      get :created_icon_likes
    end
  end
  resources :created_icon_likes, only: %i[create destroy]
  resources :icons, only: %i[index]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
