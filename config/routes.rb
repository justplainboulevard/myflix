
Rails.application.routes.draw do

  root to: 'pages#front'

  get 'register', to: 'users#new'
  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy'
  get 'home', to: 'videos#index'

  resources :users, except: [:new, :index]
  resources :videos, except: [:index] do
    collection do
      get :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  resources :categories

  get 'ui(/:action)', controller: 'ui'
end
