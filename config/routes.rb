Rails.application.routes.draw do
  resources :projects do
    resources :notes
  end
  devise_for :users
  resources :users, only: [:show] do 
    member do
      get :requests
    end
  end
  
  resources :projects do
    member do
      put "like", to: "projects#like"
    end

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
