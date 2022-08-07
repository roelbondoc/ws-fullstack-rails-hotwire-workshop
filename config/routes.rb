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

  root 'dashboard#index'
end
