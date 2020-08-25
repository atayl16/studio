# frozen_string_literal: true

Rails.application.routes.draw do
  resources :artifacts do
    member do
      put 'like', to: 'artifacts#upvote'
    end
  end
  resources :companies do
    resources :artifacts, only: [:show]
  end
  get 'home/index'
  devise_for :users
  root to: 'home#index'
  get 'billing/' => 'billing#index', as: :billing
  get '/card/new' => 'billing#new_card', as: :add_payment_method
  post '/card' => 'billing#create_card', as: :create_payment_method
  get '/success' => 'billing#success', as: :success
  post '/subscription' => 'billing#subscribe', as: :subscribe
end
