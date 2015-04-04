Rails.application.routes.draw do
  resources :users, only: %i(new create show)

  get 'profile', to: 'users#show'

  get  '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get  '/signup', to: 'users#new'

  root 'sessions#new'
end
