
Myflix::Application.routes.draw do

  get '/home', to: 'pages#home'

  resources :videos
  resources :categories

  get 'ui(/:action)', controller: 'ui'
end
