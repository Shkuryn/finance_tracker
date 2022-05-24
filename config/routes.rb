# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'welcome#index'
  resources :operations do
    resources :operation_details
  end
  resources :incomes
  resources :expences
  devise_for :users
  get 'charts/show'
end
