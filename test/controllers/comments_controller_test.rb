require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(email: 'john@ait.asia', is_member:true)
    post sessions_url, env: {'omniauth.auth': OmniAuth.config.mock_auth[:google_oauth2]}
    @idea = new_ideas(:new_idea1)
  end

  test "should get index" do
    get new_idea_comments_url(@idea)
    assert_response :success
  end

  test "should create a new comment if params are valid" do
    assert_difference('Comment.count') do
      post new_idea_comments_path(@idea), params:{comment:{description: 'This is comment'}}, xhr:true
    end
    assert_response :success
  end

  test "should not create a new comment if params are invalid" do
    assert_no_difference('Comment.count') do
      post new_idea_comments_path(@idea), params:{comment:{description: ''}}, xhr:true
    end
    assert_response :success
  end

  test "should return edit form" do
    comment = @idea.comments.build(description: 'Hello')
    comment.user = @user
    comment.save
    get edit_new_idea_comment_path(@idea,comment), xhr:true
    assert_response :success
  end

  test "should update comment" do
    comment = @idea.comments.build(description: 'Hello')
    comment.user = @user
    comment.save
    patch "/new_ideas/#{@idea.id}/comments/#{comment.id}",params:{comment:{description: 'Hello'}}, xhr:true
    assert_response :success
  end

  test "should delete comment" do
    comment = @idea.comments.build(description: 'Hello')
    comment.user = @user
    comment.save
    assert_difference('Comment.count', -1) do
      delete "/new_ideas/#{@idea.id}/comments/#{comment.id}", xhr:true
    end
  end


end
