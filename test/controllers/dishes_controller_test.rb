require 'test_helper'

class DishesControllerTest < ActionDispatch::IntegrationTest

  test 'should not create dish' do
    post dishes_edit_url
    assert_redirected_to "/menu"
  end

  test 'get all dishes' do
    get dishes_all_url
    assert_response :success
  end

end
