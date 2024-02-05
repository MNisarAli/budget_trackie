Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Define devise routes for users
  devise_for :users

  # Define routes for users, categories, and expenses
  resources :users do
    resources :categories, except: %i[edit update] do
      resources :expenses, only: %i[new create destroy]
    end
  end

  # Defines the root path route ("/")
  unauthenticated do  # Define the root route for non-logged-in users
    root 'users#index', as: :unauthenticated_root
  end

  authenticated :user do  # Define the root route for logged-in users
    root 'categories#index', as: :authenticated_root
  end
end
