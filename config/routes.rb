Rails.application.routes.draw do
  mount JasmineRails::Engine, at: '/specs'        if defined?(JasmineRails)
  mount MagicLamp::Genie,     at: '/magic_lamp'   if defined?(MagicLamp)
  mount Soulmate::Server,     at: '/autocomplete'

  resources :accounts, only: %i(index show destroy)
  resources :contacts, only: %i(index show)
  resources :tasks,    only: %i(index)

  resource :users,    only: %i(new create show)

  get 'capture',        to: 'webrtc#capture'
  get 'capture-record', to: 'webrtc#record'

  get 'dashboard', to: 'users#dashboard'

  get 'leaderboards', to: 'leaderboards#show'

  get 'profile', to: 'users#show'

  get    'signin',  to: 'sessions#new'
  post   'signin',  to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy', as: 'signout'
  get    'signup',  to: 'users#new'

  root 'users#dashboard'
end
