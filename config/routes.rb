# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :likes, only: %i[create destroy]
  resources :home do 
    collection do 
      get :confirmation
    end
  end
  resources :suggestions, only: %i[index create destroy]
  resources :posts do
    collection do
      get :pending
    end
    member do
      patch :publish
      delete :remove
      patch :set_status
    end
    resources :comments, only: %i[create update destroy]
    resources :suggestions do
      member do
        patch :apply
      end
    end
  end
  root 'posts#index'
end
