# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(site_id)
    # Anyone can login
    can :login, Site, public: true
    return unless site_id.present? && Site.exists?(site_id: site_id)

    # Guests with passcode can
    can :show, Site, site_id: site_id
    can :rsvp, Guest

    # Admin only options
    return unless Site.find_by(site_id: site_id).has_role? :admin

    can :update, Guest
  end
end
