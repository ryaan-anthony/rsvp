# frozen_string_literal: true

class Guest < ApplicationRecord
  belongs_to :parent, class_name: 'Guest', optional: true, dependent: :destroy
  has_many :guests, foreign_key: :parent_id
  accepts_nested_attributes_for :guests
  validates :first_name, presence: true
  validates :last_name, presence: true
  scope :parents, -> { where(parent_id: nil) }

  def guests_attributes
    guests.as_json(only: %i[first_name last_name status group])
  end
end
