require 'test_helper'

class VolunteerTest < ActiveSupport::TestCase

  test 'should have event' do
    user = users(:member)
    volunteer = Volunteer.new(user: user)
    assert !volunteer.valid?
    assert ["can't be blank"], volunteer.errors[:event]
  end

  test 'should have user' do
    event = events(:event_1)
    volunteer = Volunteer.new(event: event)
    assert !volunteer.valid?
    assert_equal ["can't be blank"], volunteer.errors[:user]
  end

  test 'user should be allowed to volunteer in an event only once' do
    old_volunteer = volunteers(:one)
    volunteer = Volunteer.new(user: old_volunteer.user, event: old_volunteer.event)
    assert !volunteer.valid?
    assert_equal ["has already been taken"], volunteer.errors[:user]
  end

  test 'same user can volunteer in multiple events' do
    old_volunteer = volunteers(:one)
    new_event = events(:event_2)
    volunteer = Volunteer.new(user: old_volunteer.user, event: new_event)
    assert volunteer.valid?
    assert_not_equal ["has already been taken"], volunteer.errors[:user]
  end

  test 'volunteer request should be pending when it is created' do
    user = users(:member)
    event = events(:event_2)
    volunteer = Volunteer.new(user: user, event: event)
    assert_difference('Volunteer.count') do
      volunteer.save
    end
    assert !volunteer.is_approved?
  end

end
