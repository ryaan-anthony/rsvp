# frozen_string_literal: true

Rails.application.routes.draw do
  get '/', to: 'sites#show', as: 'sites'
  get 'login', to: 'login#index'
  get 'logout', to: 'login#logout'
  post 'login', to: 'login#create'
  get 'qr', to: 'login#create'
  post 'rsvp', to: 'guests#rsvp'
  post 'assign_table', to: 'guests#assign_table'
  post 'assign_table_pos', to: 'guests#assign_table_pos'
  get 'seating_chart', to: 'guests#seating_chart'
  get 'seating_chart/:table_no', to: 'guests#table_view', as: 'table_view'
end
