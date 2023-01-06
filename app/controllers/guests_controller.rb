# frozen_string_literal: true

class GuestsController < ApplicationController
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/', warning: exception.message
  end
  rescue_from ActiveRecord::RecordInvalid do |exception|
    redirect_to '/', danger: exception.message
  end

  def rsvp
    authorize! :rsvp, Guest

    # binding.pry

    flash[:success] = 'Your RSVP status has been updated!'
    redirect_to '/'
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
