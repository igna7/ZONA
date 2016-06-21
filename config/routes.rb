Rails.application.routes.draw do

  resources :articles

  root 'welcome#index'

  get '/acerca', to: "welcome#acerca"
  get '/privacidad', to: "welcome#privacidad"
  get '/terminos', to: "welcome#terminos"
  get '/normas', to: "welcome#normas"
  get '/empleo', to: "welcome#empleo"
end
