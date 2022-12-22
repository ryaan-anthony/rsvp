# frozen_string_literal: true

class LoginController < ApplicationController
  def index; end

  def create
    session[:site_id]
    redirect_to :sites
  end
end
