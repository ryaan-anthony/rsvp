# frozen_string_literal: true

module AdminHelper
  def guests_data
    Guest.parents.as_json(
      only: %i[first_name last_name status group],
      methods: :guests_attributes
    ).to_json
  end

  def groups
    ["Angela's Family", "Ryan's Family", "Angela's Friends", "Ryan's Friends"]
  end

  def select_groups
    [['Select a group', nil]] + groups
  end

  def filter_groups
    [['Filter by group', nil]] + groups
  end

  def filter_status
    [['Filter by status', nil], 'No Response', 'Coming', 'Not Coming']
  end
end
