require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "JON SNOW IS DUMB"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", @base_title
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get projects" do
    get projects_path
    assert_response :success
    assert_select "title", "Projects | #{@base_title}"
  end

  test "should get login" do
    get login_path
    assert_response :success
    assert_select "title", "Login | #{@base_title}"
  end

end
