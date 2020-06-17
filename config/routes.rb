Rails.application.routes.draw do
  resources :artifacts
  resources :companies
  get 'home/index'
  devise_for :users
  root to: "home#index"
  get 'billing/' => 'billing#index', as: :billing
  get '/card/new' => 'billing#new_card', as: :add_payment_method
  post "/card" => "billing#create_card", as: :create_payment_method
  get '/success' => 'billing#success', as: :success
  post '/subscription' => 'billing#subscribe', as: :subscribe

end
