# frozen_string_literal: true

module AdminHelper
  def guest_collection
    @guest_collection ||= Guest.all.map do |guest|
      guest if match_filters?(guest)
    end.compact
  end

  def match_filters?(guest)
    return true if filter_params.empty?

    # partial name match
    if filter_params['name_filter'].length > 3
      return unless guest.full_name.downcase.include? filter_params['name_filter'].downcase
    end

    # match group
    if filter_params['group_filter'].present?
      return unless guest.group == filter_params['group_filter']
    end

    # match status
    if filter_params['rsvp_filter'].present?
      # check for no response or selection matches
      if filter_params['rsvp_filter'] == 'null'
        return unless guest.status.nil?
      else
        return unless guest.status.to_s == filter_params['rsvp_filter']
      end
    end

    # match welcome party
    if filter_params['welcome_filter'].present?
      # check for no response or selection matches
      if filter_params['welcome_filter'] == 'null'
        return unless guest.welcome_party.nil?
      else
        return unless guest.welcome_party.to_s == filter_params['welcome_filter']
      end
    end

    # match food choice
    if filter_params['dinner_filter'].present?
      if filter_params['dinner_filter'] == 'null'
        return unless guest.meal_choice.nil?
      else
        return unless guest.meal_choice == filter_params['dinner_filter']
      end
    end

    # passes all checks
    true
  end

  def filter_params
    params.permit(:name_filter, :group_filter, :rsvp_filter, :welcome_filter, :dinner_filter)
  end

  def humanize(boolean)
    case boolean
      when true
        'Coming'
      when false
        'Not Coming'
      else
        'No Response'
    end
  end

  def groups
    [
      "Angela's Family",
      "Ryan's Family",
      "Angela's Friends",
      "Ryan's Friends",
      "Angela's Family Friends",
      "Ryan's Family Friends"
    ]
  end

  def select_groups
    [['Select a group', nil]] + groups
  end

  def filter_groups
    [['Filter by group', nil]] + groups
  end

  def filter_status
    [['Filter by status', nil], ['Coming', true], ['Not Coming', false], ['No Response', 'null']]
  end

  def filter_dinner
    [['Filter by meal choice', nil], ['Chicken', :chicken], ['Beef', :beef], ['Fish', :fish], ['No Response', 'null']]
  end
end
