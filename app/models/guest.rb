# frozen_string_literal: true

class Guest < ApplicationRecord
  belongs_to :parent, class_name: 'Guest', optional: true, dependent: :destroy
  has_many :guests, foreign_key: :parent_id
end
