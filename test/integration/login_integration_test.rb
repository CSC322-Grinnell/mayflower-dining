require 'test_helper'

class LoginIntegrationTest < Capybara::Rails::TestCase

    setup do
        @email = 'admin@example.com'
        @pass = 'password'
    end

    test "login and logout user flow" do
        visit '/'
        assert_selector 'h1', text: 'Menu for Today'

        find('a[href="/log_in"]').click
        assert_selector 'h1', text: 'Log In'

        #fill in fields
        find('#email').fill_in with: @email
        find('#password').fill_in with: @pass
        find('input[value="Log In"]').click

        #assert redirect to root url
        assert page.has_text?('Welcome back!'), 'Successful sign in flash not present'
        assert_current_path '/'
        
        #assert logout takes back to original view
        find('a[href="/log_out"]').click
        assert page.has_text?('See you!'), 'Sign out flash not present'
        assert page.has_text?('Add Dish to Menu', count: 0), 'Add dish button present after logout'
    end

    test "admin user specific views present" do

#        assert page.has_text?('Add Dish to Menu', count: 1), 'Add dish button not present for logged in user'
    end

    test "staff user views dont have admin features" do

    end

    test "user management panel" do

    end

    test "create user" do

    end

    test "delete user" do

    end

    test "login failure" do
        visit '/'
        assert_selector 'h1', text: 'Menu for Today'

        find('a[href="/log_in"]').click
        assert_selector 'h1', text: 'Log In'

        #fill in fields
        find('#email').fill_in with: "bad@email.com" 
        find('#password').fill_in with: "assword" 
        find('input[value="Log In"]').click
        assert page.has_text?('E-mail and/or password is incorrect.'), 'Failed sign in flash not present'
    end

end
