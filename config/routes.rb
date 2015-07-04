Rails.application.routes.draw do
  require 'sidekiq/web'

  mount JasmineRails::Engine, at: 'specs'        if defined?(JasmineRails)
  mount MagicLamp::Genie,     at: 'magic_lamp'   if defined?(MagicLamp)
  mount Soulmate::Server,     at: 'autocomplete'

  root 'users#dashboard'

  resources :account_activations, only: %i(edit)
  resources :accounts,            only: %i(index show destroy)
  resources :contacts,            only: %i(index show)
  resources :tasks,               only: %i(index)

  resource :users, only: %i(new create show)

  get 'capture',        to: 'webrtc#capture'
  get 'capture-record', to: 'webrtc#record'

  get 'dashboard', to: 'users#dashboard'

  get 'leaderboards', to: 'leaderboards#show'

  get 'profile', to: 'users#show'

  get    'signin',  to: 'sessions#new'
  post   'signin',  to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy', as: 'signout'
  get    'signup',  to: 'users#new'

  namespace :admin do
    mount Sidekiq::Web, at: 'sidekiq'

    root 'pages#dashboard'

    resources :products, only: %i(index)

    get 'dashboard', to: 'pages#dashboard'
  end
end
