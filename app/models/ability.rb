# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(site_id)
    # Anyone can login
    can :login, Site, public: true

    # Anyone can see the default site and rsvp
    can :show, Site, id: Site.default.id if site_id.nil?
    can :rsvp, Guest

    return unless site_id.present? && Site.exists?(site_id: site_id)

    # Guests with passcode can view authorized site
    can :show, Site, site_id: site_id

    # Admin only options
    return unless Site.find_by(site_id: site_id).has_role? :admin

    can :table_view, Guest
    can :assign_table_pos, Guest
    can :seating_chart, Guest
    can :assign_table, Guest
    can :update, Guest
  end
end
