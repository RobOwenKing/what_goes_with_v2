Rails.application.routes.draw do
  devise_for :users
  resources :ingredients

  root 'pages#home'
end
