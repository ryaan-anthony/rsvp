# frozen_string_literal: true

Rails.application.routes.draw do
  get '/', to: 'sites#show', as: 'sites'
  get 'login', to: 'login#index'
  get 'logout', to: 'login#logout'
  post 'login', to: 'login#create'
  get 'qr', to: 'login#create'
  post 'rsvp', to: 'guests#rsvp'
  post 'assign_table', to: 'guests#assign_table'
end
