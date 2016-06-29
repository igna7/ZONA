Rails.application.routes.draw do

  resources :categories
  devise_for :users
  resources :articles do
  	member do
  		get "like", to: "articles#upvote"
  		get "dislike",to: "articles#downvote"
  	end
  end

  root 'welcome#index'

  get '/acerca', to: "welcome#acerca"
  get '/privacidad', to: "welcome#privacidad"
  get '/terminos', to: "welcome#terminos"
  get '/normas', to: "welcome#normas"
  get '/empleo', to: "welcome#empleo"
end
