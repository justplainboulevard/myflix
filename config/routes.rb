
Myflix::Application.routes.draw do

  # get '/home', to: 'pages#home'
  get '/home', to: 'videos#index'

  resources :videos, except: [:index] do
    collection do
      get :search, to: 'videos#search'
    end
  end
  resources :categories

  get 'ui(/:action)', controller: 'ui'
end
