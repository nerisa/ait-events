require 'test_helper'

class AnnouncementsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: 'john@ait.asia', is_super_admin:true)
    post sessions_url, env: {'omniauth.auth': OmniAuth.config.mock_auth[:google_oauth2]}
  end

  test 'should create a valid announcement' do
    event = events(:event_1)
    assert_difference('event.announcements.count') do
      post event_announcements_path(event), params: {announcement: {description: 'New announcement'}}, xhr: true
    end
    assert_response :success
  end

  test 'should not create an invalid announcement' do
    event = events(:event_1)
    assert_no_difference('event.announcements.count') do
      post event_announcements_path(event), params: {announcement: {description: ''}}, xhr: true
    end
  end

  test 'should update announcement' do
    event = events(:event_1)
    announcement = announcements(:one)
    patch event_announcement_path(event,announcement), params: {announcement: {description: 'This is edited'}}, xhr: true
    announcement.reload
    assert_equal announcement.description, 'This is edited'
  end

  test 'should get edit' do
    event = events(:event_1)
    announcement = announcements(:one)
    get edit_event_announcement_path(event, announcement), xhr: true
    assert_response :success
  end

  test 'should delete announcement' do
    event = events(:event_1)
    announcement = announcements(:one)
    assert_difference('event.announcements.count', -1) do
      delete event_announcement_path(event,announcement), xhr: true
    end
  end
end
