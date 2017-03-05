require 'test_helper'

class CommitteeTest < ActiveSupport::TestCase

  test "a committee should have a name" do
    committee = Committee.new(description: 'This is a committee')
    assert !committee.valid?
    assert_equal ["can't be blank"], committee.errors[:name]
  end

  test "a committee should have a description" do
    committee = Committee.new(name: 'Test Committee')
    assert !committee.valid?
    assert_equal ["can't be blank"], committee.errors[:description]
  end
end
