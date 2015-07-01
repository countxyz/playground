Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web,         at: 'admin/sidekiq'
  mount JasmineRails::Engine, at: 'specs'        if defined?(JasmineRails)
  mount MagicLamp::Genie,     at: 'magic_lamp'   if defined?(MagicLamp)
  mount Soulmate::Server,     at: 'autocomplete'

  resources :account_activations, only: %i(edit)
  resources :accounts,            only: %i(index show destroy)
  resources :contacts,            only: %i(index show)
  resources :tasks,               only: %i(index)

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

  namespace :admin do
    get 'dashboard', to: 'dashboard#dashboard'

    root 'dashboard#dashboard'
  end

  root 'users#dashboard'
end
