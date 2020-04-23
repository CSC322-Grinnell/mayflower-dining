require 'test_helper'

class AuthTest < ActionDispatch::IntegrationTest

  # test users
  setup do
    login_user("admin@example.com")
  end

  teardown do
    logout_user
  end

  test "differnt view for loggedin user" do
    get root_url
    assert_response :success
    assert_select 'h1', 'Menu for Today'
    assert_select 'button', 'Add Dish to Menu'
    assert_select 'a', 'TEMP remove dish'
    assert_select 'a', 'PERM remove dish'
  end
end
