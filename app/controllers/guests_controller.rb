# frozen_string_literal: true

class GuestsController < ApplicationController
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/', warning: exception.message
  end
  rescue_from ActiveRecord::RecordInvalid do |exception|
    redirect_to '/', danger: exception.message
  end
  helper GuestsHelper

  def seating_chart
    authorize! :seating_chart, Guest

    render 'seating_chart'
  end

  def assign_table
    authorize! :assign_table, Guest

    table = params.fetch(:table)
    guest = Guest.find(params.fetch(:guest_id))
    guest.update!(table: table)

    flash[:success] = "#{guest.full_name} has been added to table #{table}."
    redirect_back fallback_location: '/'
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

  private

  def rsvp_params
    params.require(:rsvp)
  end

  def guests_params
    JSON.parse(params.require(:guests_data))
  end
end
