# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(site_id)
    can :login, Site, public: true
    return unless site_id.present?

    can :index, Site, site_id: site_id
  end
end
