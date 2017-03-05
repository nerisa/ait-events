require 'test_helper'

class VolunteerControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: 'john@ait.asia', is_super_admin:true)
    post sessions_url, env: {'omniauth.auth': OmniAuth.config.mock_auth[:google_oauth2]}
  end

  test 'should get index' do
    volunteer = volunteers(:one)
    get event_volunteers_path(volunteer.event)
    assert_response :success
  end

  test 'should add a new volunteer' do
    event = events(:event_1)
    assert_difference('event.volunteers.count') do
      get event_add_volunteer_path(event), xhr: true
    end
  end

  test 'should accept a volunteer request' do
    volunteer = volunteers(:one)
    get event_accept_volunteer_path(volunteer.event, volunteer)
    volunteer.reload
    assert volunteer.is_approved?
    assert_equal "User #{volunteer.user.username} has been added to the volunteer list.", flash[:message]
    assert_redirected_to event_volunteers_path
  end

  test 'should not reject a volunteer request' do
    volunteer = volunteers(:approved_volunteer)
    get event_reject_volunteer_path(volunteer.event, volunteer)
    volunteer.reload
    assert !volunteer.is_approved?
    assert_equal "User #{volunteer.user.username} has been removed from the volunteer list.", flash[:message]
    assert_redirected_to event_volunteers_path
  end
end
