Rails.application.routes.draw do
  resources :votes, except: [:edit]
  resources :polls, except: [:edit] do
    resources :results, only: :index, module: 'polls'
  end

  namespace :dashboard do
    resources :stats, only: :index
  end

  resources :candidates, except: [:edit]
  resources :users, except: [:edit]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
