require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get add_item" do
    get static_pages_add_item_url
    assert_response :success
  end

end
