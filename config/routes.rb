Rails.application.routes.draw do
  mount JasmineRails::Engine, at: '/specs'      if defined?(JasmineRails)
  mount MagicLamp::Genie,     at: '/magic_lamp' if defined?(MagicLamp)

  resources :accounts, only: %i(index show)
  resources :contacts, only: %i(index show)
  resources :tasks,    only: %i(index)
  resources :users,    only: %i(new create show)

  get 'profile', to: 'users#show'

  get    'signin',  to: 'sessions#new'
  post   'signin',  to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy', as: 'signout'
  get    'signup',  to: 'users#new'

  root 'sessions#new'
end
