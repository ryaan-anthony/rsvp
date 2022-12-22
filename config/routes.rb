# frozen_string_literal: true

Rails.application.routes.draw do
  get '/', to: 'sites#index'
  get 'login', to: 'login#index'
  post 'login', to: 'login#create'
end
