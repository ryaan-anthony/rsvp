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

    rsvp_params.each do |guest_id, request|
      guest = Guest.find(guest_id)
      guest.update!(status: request[:status])
    end

    flash[:success] = 'Thank you! Your response has been recorded.'
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

  private

  def rsvp_params
    params.require(:rsvp)
  end

  def guests_params
    JSON.parse(params.require(:guests_data))
  end
end
