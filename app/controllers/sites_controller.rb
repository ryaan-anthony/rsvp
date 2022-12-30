# frozen_string_literal: true

class SitesController < ApplicationController
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to :login, warning: 'Passcode is required.'
  end
  helper AdminHelper

  def show
    authorize! :show, current_site

    render current_site.template
  end
end
