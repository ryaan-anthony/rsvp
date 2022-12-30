# frozen_string_literal: true

class SitesController < ApplicationController
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to :login, warning: 'Passcode is required.'
  end
  before_action :load_guests

  def show
    authorize! :show, current_site

    render current_site.template
  end

  private

  def load_guests
    @guests = Guest.parents.as_json(
      only: %i[first_name last_name status group],
      methods: :guests_attributes
    )
  end
end
