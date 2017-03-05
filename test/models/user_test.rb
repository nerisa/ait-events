require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "email of the user should not be empty" do
    user = User.new(provider: 'google', uid: '123456789', oauth_token: '123456789', oauth_expires_at: Date.today())
    assert !user.valid?
    assert_equal ["Please enter email for the user"], user.errors[:email]
  end

  test "email of the user should be unique" do
    old_user = users(:super_admin)
    new_user = User.new(email: old_user.email)
    assert !new_user.valid?
    assert_equal ["The user with this email has already registered"], new_user.errors[:email]
  end

  test "a superadmin should have its other roles set to false" do
    user = User.new(is_super_admin: true)
    user.send(:default_values)
    assert !user.is_master_admin?
    assert !user.is_member?
  end

  test "a user created with no role specified should be a member" do
    user = User.new
    user.send(:default_values)
    assert !user.is_super_admin?
    assert user.is_member?
    assert !user.is_master_admin?
  end

  test "a new user should have access to the system" do
    user = User.new
    user.send(:default_values)
    assert user.has_access?
  end

  test "a masteradmin should have its other roles set to false" do
    user = User.new(is_master_admin: true)
    user.send(:default_values)
    assert !user.is_super_admin?
    assert !user.is_member?
  end

  test "username of a user should return his/her name if it exists else email should be returned" do
    user = users(:member)
    assert_equal user.username, user.email
  end

end
