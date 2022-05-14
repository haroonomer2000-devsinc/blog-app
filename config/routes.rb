Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users
  resources :posts do 
    collection do
      get :pending
    end
    member do 
      patch :publish
      delete :remove
    end
    resources :comments, only: [:create, :destroy]
    resources :suggestion, only: [:create, :destroy]
  end

  root "posts#index"
end
