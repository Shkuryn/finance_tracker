# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'
  resources :operations do
    resources :operation_details
  end
  resources :expences
  devise_for :users
  get 'charts/show'
end
