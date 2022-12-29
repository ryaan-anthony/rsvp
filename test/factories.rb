# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :guest do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    transient do
      plus_one { 1 }
    end

    factory :guest_with_guests, parent: :guest do
      after(:create) { |guest, evaluator| evaluator.plus_one.times { create(:guest, parent_id: guest.id) } }
    end
  end
end
