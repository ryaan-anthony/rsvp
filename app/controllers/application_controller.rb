# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :info, :warning, :danger

  rescue_from StandardError do |exception|
    ExceptionMailer.send_alert(exception, request).deliver
    raise exception
  end

  def current_ability
    @current_ability ||= Ability.new(site_id)
  end

  def site_id
    @site_id ||= session[:site_id]
  end

  def current_site
    @current_site ||= Site.where(site_id: site_id).first || Site.default
  end
end
