require 'test_helper'

class NewIdeasControllerTest < ActionDispatch::IntegrationTest

  setup :login

  test "should get index" do
    get new_ideas_url
  end

  test "should create a new idea if the params are valid" do
    assert_difference('NewIdea.count') do
      post new_ideas_url, params: {new_idea: {committee_id: 1, name: 'New Idea', description: 'This is a new idea'}}, xhr: true
    end
  end

  test "should not create a new idea if the params are invalid" do
    assert_no_difference('NewIdea.count') do
      post new_ideas_url, params: {new_idea: {committee_id: 1, name: '', description: 'This is a new idea'}}, xhr: true
    end
  end

  test "should show new idea" do
    @new_idea = new_ideas(:new_idea1)
    get "/new_ideas/#{@new_idea.id}"
    assert_response :success
  end

  test "should ban new idea" do
    @new_idea = new_ideas(:new_idea1)
    patch "/new_ideas/#{@new_idea.id}/ban_idea", xhr:true
    assert_response :success
  end

  test "should close new idea" do
    @new_idea = new_ideas(:new_idea1)
    patch new_idea_close_idea_path(@new_idea), xhr:true
    assert_response :success
  end

  def login
    User.create(email: 'john@ait.asia', is_super_admin:true)
    post sessions_url, env: {'omniauth.auth': OmniAuth.config.mock_auth[:google_oauth2]}
  end

end
