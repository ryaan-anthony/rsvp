# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(site_id)
    can :login, Site, public: true
    return unless site_id.present? && Site.exists?(site_id: site_id)

    can :show, Site, site_id: site_id
  end
end