# frozen_string_literal: true

class LoginController < ApplicationController
  rescue_from ActionController::ParameterMissing do |exception|
    redirect_to :login, danger: I18n.t('unauthorized.default')
  end

  def index; end

  def create
    session[:site_id] = params.require(:passcode)
    redirect_to :sites
  end
end
