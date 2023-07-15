# frozen_string_literal: true

class Guest < ApplicationRecord
  enum meal_choice: %i[beef chicken fish]
  belongs_to :parent, class_name: 'Guest', optional: true
  has_many :guests, foreign_key: :parent_id, dependent: :destroy
  accepts_nested_attributes_for :guests
  validates :first_name, presence: true
  # validates :last_name, presence: true
  scope :parents, -> { where(parent_id: nil) }
  scope :coming, -> { where(status: true) }
  scope :not_coming, -> { where(status: false) }
  scope :no_response, -> { where(status: nil) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def status_message
    case status
    when true
      'is coming!'
    when false
      'is not coming.'
    else
      'has not responded.'
    end
  end

  def guests_attributes
    guests.as_json(only: %i[first_name last_name status group meal_choice])
  end

  def guests_attributes_rsvp
    guests.as_json(only: %i[id first_name last_name status meal_choice])
  end
end
