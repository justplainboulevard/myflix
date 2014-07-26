
Myflix::Application.routes.draw do

  get '/', to: 'sessions#front'
  get '/register', to: 'users#new'
  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#new'
  get '/home', to: 'videos#index'

  resources :users, except: [:new, :index]
  resources :videos, except: [:index] do
    collection do
      get :search, to: 'videos#search'
    end
  end
  resources :categories

  get 'ui(/:action)', controller: 'ui'
end
