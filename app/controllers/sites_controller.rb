# frozen_string_literal: true

class SitesController < ApplicationController
  load_and_authorize_resource

  def index
    render @site.template
  end

  # def confirm
  #   # TODO: check if pw is valid
  #   # TODO: set pw in session
  #   # TODO: redirect to welcome#index
  # end
  #
  # private
  #
  # def require_login
  #   return if current_site?
  #
  #   flash[:error] = 'You must be logged in to access this section'
  #   redirect_to confirm_path
  # end
end
