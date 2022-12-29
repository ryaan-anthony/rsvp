# frozen_string_literal: true

Rails.application.routes.draw do
  get '/', to: 'sites#show', as: 'sites'
  get 'login', to: 'login#index'
  post 'login', to: 'login#create'
  patch 'guests', to: 'guests#update'
end
