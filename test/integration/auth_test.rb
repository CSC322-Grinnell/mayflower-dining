require 'test_helper'

class AuthTest < ActionDispatch::IntegrationTest

  # test users
  setup do
    @admin_email = "admin@example.com"
    login_user(@admin_email)
  end

  teardown do
    logout_user
  end

  test "different view for loggedin user" do
    get root_url
    assert_response :success
    assert_select 'h1', 'Menu for Today'
    assert_select 'button', 'Add Dish to Menu'
    assert_select 'a', 'TEMP remove dish'
    assert_select 'a', 'PERM remove dish'
  end

  test "admin cant change their own privileges" do
    get '/users/' + User.find_by(email: @admin_email).id.to_s + '/edit'

    #assert all fields other than privs are present
    assert_select '#user_email', true, "User email form field not present"
    assert_select '#user_name', true, "User name form field not present"
    assert_select '#user_password', true, "User password form field not present"
    assert_select '#user_password_confirmation', true, "User password confirmation form field not present"
    assert_select '#user_admin', false, "User privilege form field present for self edit"
  end
end
