require 'test_helper'



class ApplicationHelperTest < ActionView::TestCase

  def setup
    @base_title = 'JON SNOW IS DUMB'
  end

  test "full title helper" do

    assert_equal full_title, @base_title

    assert_equal full_title("About"), "About | #{@base_title}"

  end

end