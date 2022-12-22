# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :login, alert: exception.message
  end

  def current_user
    session[:site_id]
  end
end
