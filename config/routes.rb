Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :players, only: [:index]
  resources :teams, only: [:index]
end
