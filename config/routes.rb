Rails.application.routes.draw do
  resources :games, only: [:index]

  root to: 'games#index'
end
