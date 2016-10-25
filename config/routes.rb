Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  resources :categories
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resources :user
  resources :articles do
  	member do
  		get "like", to: "articles#upvote"
  		get "dislike",to: "articles#downvote"
  	end
  end

  root 'articles#index'

  get '/welcome', to: "welcome#index"
  get '/acerca', to: "welcome#acerca"
  get '/privacidad', to: "welcome#privacidad"
  get '/terminos', to: "welcome#terminos"
  get '/normas', to: "welcome#normas"
  get '/empleo', to: "welcome#empleo"
end
