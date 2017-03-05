require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "a new user should be created when the user doesnot exist" do
    assert_difference('User.count') do
      post sessions_url, env: {'omniauth.auth': OmniAuth.config.mock_auth[:google_oauth2]}
    end
  end

  test "a new user should not be created when the auth_params belongs to a user" do
    User.create(email: 'john@ait.asia')
    assert_no_difference('User.count') do
      post sessions_url, env: {'omniauth.auth': OmniAuth.config.mock_auth[:google_oauth2]}
    end
  end

  test "a user who is a member should be redirected to the user's dashboard" do
    User.create(email: 'john@ait.asia')
    post sessions_url, env: {'omniauth.auth': OmniAuth.config.mock_auth[:google_oauth2]}
    assert_redirected_to new_ideas_url
  end

  test "a user who is an admin should be redirected to the admin dashboard" do
    User.create(email: 'john@ait.asia', is_super_admin: true)
    post sessions_url, env: {'omniauth.auth': OmniAuth.config.mock_auth[:google_oauth2]}
    assert_redirected_to users_index_url
  end

  test "the session should be nullified once a signed in user logs out" do
    @user =  User.create(email: 'john@ait.asia', is_super_admin: true)
    post sessions_url, env: {'omniauth.auth': OmniAuth.config.mock_auth[:google_oauth2]}
    delete session_url(@user)
    assert_nil(session[:user_id])
  end

  test "user should be redirected to the home page once a signed in user logs out" do
    @user =  User.create(email: 'john@ait.asia', is_super_admin: true)
    post sessions_url, env: {'omniauth.auth': OmniAuth.config.mock_auth[:google_oauth2]}
    delete session_url(@user)
    assert_redirected_to root_url
  end

  test "a banned user should not be allowed to login" do
    @user =  User.create(email: 'john@ait.asia', has_access: false)
    post sessions_url, env: {'omniauth.auth': OmniAuth.config.mock_auth[:google_oauth2]}
    assert_equal(flash[:error],"You have been revoked access to this page")
    assert_redirected_to root_url
  end

  test "authentication failure should redirect users to root url" do
    post sessions_url, env: {'omniauth.auth': ''}
    assert_equal(flash[:error],"Error occured while logging you in")
    assert_redirected_to root_url
  end

end
