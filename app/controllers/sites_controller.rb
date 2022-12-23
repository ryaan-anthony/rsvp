# frozen_string_literal: true

class SitesController < ApplicationController
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :login, warning: exception.message
  end

  def show
    authorize! :show, current_site
    render current_site.template
  end
end
