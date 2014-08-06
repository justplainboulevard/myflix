
Rails.application.routes.draw do

  root to: 'pages#front'

  get 'register', to: 'users#new'
  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy'
  get 'home', to: 'videos#index'
  get 'my_queue', to: 'queue_items#index'

  resources :users, except: [:new, :index]
  resources :videos, except: [:index] do
    collection do
      get :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  resources :categories
  resources :queue_items, only: [:create, :destroy]

  get 'ui(/:action)', controller: 'ui'
end
