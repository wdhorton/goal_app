Rails.application.routes.draw do
  resources :users do
    resources :user_comments, only: [:create]
  end

  resource :session

  resources :goals do
    resources :goal_comments, only: [:create]
  end

  resources :user_comments, except: [:new, :create]
end
