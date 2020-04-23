require 'test_helper'

class DishesControllerTest < ActionDispatch::IntegrationTest

  test 'should not create dish' do
    #attempt to edit dishes w/o login. This feature is still broken, so no success test yet
    post dishes_edit_url
    assert_redirected_to "/log_in"
    follow_redirect!
    assert_select '.alert-warning', "You must be an admin user to access this page."
  end

  test 'get all dishes' do
    #attempt to get dishes w/o login
    get dishes_all_url
    assert_redirected_to "/log_in"
    follow_redirect!
    assert_select '.alert-warning', "You must be an admin user to access this page."

    #login and successfully get dishes
    login_user('admin@example.com')

    get dishes_all_url
    assert_response :success
  end

end
