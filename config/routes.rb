Rails.application.routes.draw do
  
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:show] do 
    member do
      get :requests
    end
  end
  
  resources :projects do
    member do
      put 'like', to: "projects#like"
      put 'bump', to: "projects#bump"
    end

    resources :notes

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
