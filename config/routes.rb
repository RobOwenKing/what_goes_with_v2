Rails.application.routes.draw do
  devise_for :users

  resources :comments, except: %i[index show]
  resources :ingredients
  resources :pairs, only: %i[index show new]

  root 'pages#home'
end
