require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup :login

  test "should get index page" do
    get users_index_url
    assert_response :success
  end

  # # TODO
  # test "should ban user" do
  #   @user = users(:member)
  #   get users_ban_users_url(@user)
  #   assert_equal(flash[:message], "User #{@user.email} has been banned from AIT Events")
  #   assert_redirected_to users_index_url
  # end

  test "should get banned users list" do
    get users_show_banned_users_path
    assert_response :success
  end

  def login
    User.create(email: 'john@ait.asia', is_super_admin:true)
    post sessions_url, env: {'omniauth.auth': OmniAuth.config.mock_auth[:google_oauth2]}
  end

end
