# frozen_string_literal: true

class LoginController < ApplicationController
  rescue_from ActionController::ParameterMissing do |exception|
    redirect_to :login, danger: 'Passcode is required!'
  end

  def index; end

  def create
    session[:site_id] = params.require(:passcode)
    redirect_to :sites
  end
end
