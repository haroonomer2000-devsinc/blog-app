Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :likes, only: [:create, :destroy]
  resources :posts do 
    collection do
      get :pending
    end
    member do 
      patch :publish
      delete :remove
    end
    resources :comments do 
      patch :report 
      patch :accept_report
      patch :deny_report
    end
    resources :suggestion do 
      member do 
        patch :apply
      end
    end
  end
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  root "posts#index"
end
