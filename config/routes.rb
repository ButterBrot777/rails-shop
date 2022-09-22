# frozen_string_literal: true

Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'sessions/create'
  get 'sessions/destroy'

  resources :users
  resources :orders
  resources :line_items
  resources :carts
  resources :products
  resources :store

  resources :products do
    get :who_bought, on: :member
  end

  resources :support_requests, only: [ :index, :update ]

  root 'store#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
