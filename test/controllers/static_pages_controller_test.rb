require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get menu" do
    get static_pages_menu_url
    assert_response :success
  end

end
