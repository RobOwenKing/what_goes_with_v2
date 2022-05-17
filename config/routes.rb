Rails.application.routes.draw do
  devise_for :users

  resources :ingredients
  resources :pairs, only: %i[show new]

  root 'pages#home'
end
