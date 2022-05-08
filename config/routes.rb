# frozen_string_literal: true

Rails.application.routes.draw do

  resources :expences
  devise_for :users
  root 'welcome#index'
end
