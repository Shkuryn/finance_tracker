# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'dashboard#show'
  resources :operations do
    resources :operation_details, shallow: true
  end
  resources :incomes
  resources :expences
  resources :planned_expences
  devise_for :users
  resources :charts, only: %i[show index create]
  # get 'charts/show'
  get 'dashboard/show'
  resources :users
end
