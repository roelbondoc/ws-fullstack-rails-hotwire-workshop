Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :clients do
    resources :accounts
  end

  resources :orders do
    post :accept, on: :member
    post :reject, on: :member
    post :accept_all, on: :collection
    post :reject_all, on: :collection
  end

  resources :activities
  resources :asset_classes
  resources :portfolios
  resources :securities

  get '/search/results', to: 'search#results'

  get 'dashboard/client_count', to: 'dashboard#client_count'
  get 'dashboard/account_count', to: 'dashboard#account_count'
  get 'dashboard/biggest_account', to: 'dashboard#biggest_account'
  get 'dashboard/aum', to: 'dashboard#aum'

  root 'dashboard#index'
end
