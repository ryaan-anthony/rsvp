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

    guests = []
    rsvp_params.each do |guest_id, request|
      guest = Guest.find(guest_id)
      guest.update!(request.permit(:status, :meal_choice, :welcome_party))
      # Only send alert for top level guest
      guests << guest unless guest.parent_id?
    end
    # Send email after all guests have been updated
    guests.each do |guest|
      GuestUpdateMailer.send_alert(guest).deliver
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
