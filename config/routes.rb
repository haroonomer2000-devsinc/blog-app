Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users
  resources :posts do 
    collection do
      get :pending
    end
    member do 
      patch :publish
      patch :unpublish
    end
    resources :comments, only: [:create]
  end

  root "posts#index"
end
