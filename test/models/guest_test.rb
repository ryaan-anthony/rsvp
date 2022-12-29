require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  test 'guest factory is valid' do
    assert build(:guest).valid?
  end

  test 'guest with guests factory is valid' do
    assert build(:guest_with_guests, plus_one: 2).valid?
  end

  test 'deleting guest will remove their guests' do
    guest = create(:guest_with_guests, plus_one: 2)
    assert_equal 3, Guest.count
    guest.destroy
    assert_equal 0, Guest.count
  end
end
