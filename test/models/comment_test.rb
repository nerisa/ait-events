require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test "a comment should not have a empty description field" do
    comment = Comment.new
    assert !comment.valid?
    assert_equal ["can't be blank"], comment.errors[:description]
  end

  test "a comment should always belong to a user" do
    idea = new_ideas(:new_idea1)
    comment = Comment.new(description:'This is a comment', new_idea: idea)
    assert !comment.valid?
    assert_equal ["can't be blank"], comment.errors[:user]
  end

  test "a comment should always belong to a new idea" do
    comment = Comment.new(description:'This is a comment', user: users(:member))
    assert !comment.valid?
    assert_equal ["can't be blank"], comment.errors[:new_idea]
  end
end
