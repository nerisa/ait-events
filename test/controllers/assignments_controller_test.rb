require 'test_helper'

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get ps3" do
    get assignments_ps3_url
    assert_response :success
  end

  test "should get ps4" do
    get assignments_ps4_url
    assert_response :success
  end

  test "should get ps5" do
    get assignments_ps5_url
    assert_response :success
  end

  test "should profile 1" do
    get assignments_ps3_profile1_path
    assert_response :success
  end

  test "should profile 2" do
    get assignments_ps3_profile2_path
    assert_response :success
  end

  test "should profile 3" do
    get assignments_ps3_profile3_path
    assert_response :success
  end

end
