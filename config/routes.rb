
Myflix::Application.routes.draw do

  get '/home', to: 'pages#home'
  get '/videos', to: 'pages#home'

  resources :videos, except: [:index] do
    collection do
      get :search, to: 'videos#search'
    end
  end
  resources :categories

  get 'ui(/:action)', controller: 'ui'
end
