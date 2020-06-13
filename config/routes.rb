Rails.application.routes.draw do
  resources :artifacts
  resources :companies
  get 'home/index'
  devise_for :users
  root to: "home#index"
end
