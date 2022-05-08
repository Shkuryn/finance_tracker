# frozen_string_literal: true

Rails.application.routes.draw do

  resources :operation_details
  resources :operations
  resources :expences
  devise_for :users
  root 'welcome#index'
end
