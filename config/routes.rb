# frozen_string_literal: true

Rails.application.routes.draw do
  resources :orders
  resources :line_items
  resources :carts
  resources :products
  resources :store

  resources :products do
    get :who_bought, on: :member
  end

  root 'store#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
