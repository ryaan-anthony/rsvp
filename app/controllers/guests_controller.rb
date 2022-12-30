# frozen_string_literal: true

class GuestsController < ApplicationController
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/', warning: exception.message
  end

  def update
    authorize! :update, Guest

    ActiveRecord::Base.transaction do
      Guest.destroy_all
      Guest.create!(guests_params)
    end

    flash[:success] = 'Guest list has been updated!'
    redirect_to '/'
  end

  def guests_params
    JSON.parse(params.require(:guests_data))
  end
end
