Rails.application.routes.draw do
  devise_for :users
  resources :projects do 
    resources :requests, only: [:create, :destroy] do
      member do
        patch :accept
        patch :decline
      end
    end
    resources :memberships, only: [:destroy]
  end
  
  root 'projects#index'
end
