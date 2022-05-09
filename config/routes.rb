# frozen_string_literal: true

Rails.application.routes.draw do

  resources :operations do
    resources :operation_details
  end
  resources :expences
  devise_for :users
  root 'welcome#index'
end
