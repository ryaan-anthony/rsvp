# frozen_string_literal: true

module GuestsHelper
  def table_layout
    [
      [4,1,7,10],
      [5,2,8,11],
      [6,3,9,12],
      (13..16).to_a,
      (17..20).to_a
    ]
  end

  def assign_tables
    [['None', nil]] + (1..20).to_a
  end
end
