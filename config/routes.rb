# frozen_string_literal: true

Rails.application.routes.draw do
  get '/', to: 'sites#show', as: 'sites'
  get 'login', to: 'login#index'
  post 'login', to: 'login#create'
  get 'qr', to: 'login#create'
  post 'guests', to: 'guests#update'
  post 'rsvp', to: 'guests#rsvp'
end
