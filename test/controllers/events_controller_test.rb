require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: 'john@ait.asia', is_super_admin:true)
    post sessions_url, env: {'omniauth.auth': OmniAuth.config.mock_auth[:google_oauth2]}
  end

  test 'should get index' do
    get events_path
    assert_response :success
  end

  test 'should get index with params' do
    committee = committees(:committee_1)
    get events_path, params: {committee: committee.id}
    assert_response :success
  end

  test 'should show event' do
    event = events(:event_1)
    get event_path(event)
    assert_response :success
  end

  test 'should get new' do
    get new_event_path
    assert_response :success
  end

  test 'should get edit' do
    event = events(:event_1)
    get edit_event_path(event)
    assert_response :success
  end

  test 'should create a event' do
    committee = committees(:committee_1)
    assert_difference('Event.count') do
      post events_path, params: {event:{committee_id: committee.id, name: 'Event 1', description: 'This is a new event', venue: 'AITCC' }}
    end
  end

  test 'event should not be created in case of invalid event details' do
    committee = committees(:committee_1)
    assert_no_difference('Event.count') do
      post events_path, params: {event:{committee_id: committee.id, description: 'This is a new event', venue: 'AITCC' }}
    end
  end

  test "event created by the master admin should belong to the master admin's committee" do
    @user.is_super_admin = false
    @user.is_master_admin = true
    @user.save!
    committee = Committee.create(name: 'Test', description: 'Test', user: @user)
    assert_difference('Event.count') do
      post events_path, params: {event:{name: 'Event 1', description: 'This is a new event', venue: 'AITCC' }}
    end
  end

  test "event should be edited" do
    event = events(:event_1)
    patch event_path(event), params: {event: {name:'Edited Event', description: 'This has been edited', venue: 'AITCC'}}
    event.reload
    assert_equal 'Edited Event', event.name
    assert_equal 'Your event has been updated successfully.', flash[:message]
    assert_redirected_to event_path(event)
  end

  test "event should not be updated with invalid data" do
    event = events(:event_1)
    patch event_path(event), params: {event: {name:'', description: 'This has been edited', venue: 'AITCC'}}
    event.reload
    assert_not_equal event.description, 'This has been edited'
  end

  test "should delete event" do
    event = events(:event_1)
    event_name = event.name
    assert_difference('Event.count', -1) do
      delete event_path(event)
    end
    assert_equal "Your event #{event_name} has been deleted.", flash[:message]
  end

end
