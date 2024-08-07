Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root "static_pages#top"
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  get 'terms_of_use', to: 'static_pages#terms_of_use'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  post '/guest_login', to: 'user_sessions#guest_login'

  resources :users, only: %i[new create]
  resource :profile, only: %i[show edit update]
  resources :post_icons do
    collection do
      get :post_icon_likes
    end
  end
  resources :created_icons do
    collection do
      get :created_icon_likes
    end
  end
  resources :created_icon_likes, only: %i[create destroy]
  resources :post_icon_likes, only: %i[create destroy]
  resources :icons, only: %i[index]
  resources :like_icons, only: %i[index]
  resources :password_resets, only: [:new, :create, :edit, :update]

  # 管理画面用
  namespace :admin do
    root 'dashboards#index'
    resources :users
    resources :post_icons
    resources :created_icons
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
  end
end
