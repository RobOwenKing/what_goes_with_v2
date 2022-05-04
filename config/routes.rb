Rails.application.routes.draw do
  devise_for :users
  resources :ingredients, except: %i[index]

  root 'pages#home'
end
