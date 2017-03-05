require 'test_helper'

class AnnouncementTest < ActiveSupport::TestCase

  test 'should have a description' do
    announcement = Announcement.new
    assert !announcement.valid?
    assert_equal ["can't be blank"], announcement.errors[:description]
  end
end
