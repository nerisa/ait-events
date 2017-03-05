require 'test_helper'

class CommitteesControllerTest < ActionDispatch::IntegrationTest

  def setup
    User.create(email: 'john@ait.asia', is_member:true)
    post sessions_url, env: {'omniauth.auth': OmniAuth.config.mock_auth[:google_oauth2]}
  end

  test "should get show" do
    committee = committees(:committee_1)
    get committee_path(committee)
    assert_response :success
  end

end
