require 'test_helper'

class DishesControllerTest < ActionDispatch::IntegrationTest

  test 'should_not_create_dish' do
    post dishes_edit_url
    assert_redirected_to "/menu"
  end

  test 'should_return_succeed' do
    get dishes_all_url
    assert_response :success
  end

end
