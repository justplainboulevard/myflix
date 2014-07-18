Myflix::Application.routes.draw do

  get '/home', to: 'pages#home'

  get 'ui(/:action)', controller: 'ui'
end
