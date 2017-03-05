require 'test_helper'

class NewIdeaTest < ActiveSupport::TestCase

  test "a new idea should not have an empty description" do
    idea = NewIdea.new(committee: committees(:committee_1), user: users(:member))
    assert !idea.valid?
    assert_equal ["can't be blank"], idea.errors[:description]
  end

  test "a new idea should belong to a user" do
    idea = NewIdea.new(committee: committees(:committee_1), description: 'This is a new idea')
    assert !idea.valid?
    assert_equal ["can't be blank"], idea.errors[:user]
  end

  test "a new idea should belong to a committee" do
    idea = NewIdea.new(user: users(:member), description: 'This is a new idea')
    assert !idea.valid?
    assert_equal ["can't be blank"], idea.errors[:committee]
  end

  test "a new idea created should not be closed and should be allowed to display" do
    idea = NewIdea.new(user: users(:member), description: 'This is a new idea', committee: committees(:committee_1))
    idea.send(:default_values)
    assert !idea.restrict_display?
    assert !idea.is_closed?
  end

  test "a new idea's author is the user assigned to the idea" do
    user = users(:member)
    idea = NewIdea.new(user: user , description: 'This is a new idea', committee: committees(:committee_1))
    assert_equal idea.author, user
  end

  test "a new idea should have a name" do
    idea = NewIdea.new
    assert !idea.valid?
    assert_equal ["can't be blank"], idea.errors[:name]
  end

end
