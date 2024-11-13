Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :sessions, only: [:create, :destroy]

  post 'wallets/transfer', to: 'wallets#transfer'
  post 'wallets/top_up', to: 'wallets#top_up'
  get 'wallets/balance', to: 'wallets#balance'
  get 'wallets/transaction_history', to: 'wallets#transaction_history'

  get 'stocks/fetch', to: 'stocks#fetch_stock_data'
end
