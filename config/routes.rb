Rails.application.routes.draw do
  resources :users

  resource :session

  resources :goals do
    resources :cheers, only: [:create]
  end

  resources :comments


end
