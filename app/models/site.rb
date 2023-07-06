# frozen_string_literal: true

class Site < ApplicationRecord
  rolify

  scope :default, -> { where(default: true).first }
end
