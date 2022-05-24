# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/confirmation'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :likes, only: %i[create destroy]
  resources :suggestions do
    collection do
      get :by_user
    end
    member do
      delete :remove
    end
  end
  resources :posts do
    collection do
      get :pending
    end
    member do
      patch :publish
      delete :remove
      patch :set_status
    end
    resources :comments do
      patch :set_status
    end
    resources :suggestions do
      member do
        patch :apply
      end
    end
  end
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
  root 'posts#index'
end
