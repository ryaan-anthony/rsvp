# frozen_string_literal: true

class LoginController < ApplicationController
  rescue_from ActionController::ParameterMissing do
    redirect_to :login, danger: 'Passcode is required.'
  end

  def index; end

  def logout
    reset_session
    redirect_to :sites
  end

  def create
    session[:site_id] = params.require(:passcode).downcase
    redirect_to :sites
  end
end
