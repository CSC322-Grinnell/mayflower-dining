require 'test_helper'

class PrepControllerTest < ActionDispatch::IntegrationTest
  test "should get prep-page" do
    get prep_prep-page_url
    assert_response :success
  end

end
