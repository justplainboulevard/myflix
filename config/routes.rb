
Rails.application.routes.draw do

  root to: 'pages#front'

  get 'home', to: 'videos#index'
  get 'my_queue', to: 'queue_items#index'

  get 'register', to: 'users#new'
  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy'

  get 'people', to: 'relationships#index'

  resources :users, except: [:new, :index]
  resources :relationships, only: [:destroy]
  resources :categories
  resources :videos, except: [:index] do
    collection do
      get :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'

  get 'ui(/:action)', controller: 'ui'
end
