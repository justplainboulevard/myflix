
Rails.application.routes.draw do

  root to: 'pages#front'

  get 'home', to: 'videos#index'
  get 'my_queue', to: 'queue_items#index'

  get 'register', to: 'users#new'
  get 'register/:token', to: 'users#new_with_invitation_token', as: 'register_with_token'
  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy'

  get 'people', to: 'relationships#index'

  namespace :admin do
    resources :videos, only: [:new, :create]
  end

  resources :payments, only: [:new, :create]
  resources :users, except: [:new, :index]
  resources :relationships, only: [:create, :destroy]
  resources :categories
  resources :videos, except: [:index] do
    collection do
      get :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'

  get 'forgot_password', to: 'password_reset#new'
  post 'password_reset/:id', to: 'password_reset#reset_password'
  resources :password_reset, only: [:create, :show]
  get 'password_reset_confirmation', to: 'password_reset#confirm'
  get 'expired_token', to: 'pages#expired_token'

  resources :invitations, only: [:new, :create]

  get 'ui(/:action)', controller: 'ui'

  mount StripeEvent::Engine => '/stripe_events'
end
