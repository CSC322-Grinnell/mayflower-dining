require 'test_helper'

class LoginIntegrationTest < Capybara::Rails::TestCase

    setup do
        u = User.all()[0]
        puts "----- #{User.all().size} the email is ::::: #{u.email}"
        puts u.methods.sort
        @email = 'admin@example.com'
        @pass = 'password'
    end

    test "login and logout user flow" do
        visit '/'
        assert_selector 'h1', text: 'Menu for Today'

        find('a[href="/users/sign_in"]').click
        assert_selector 'h2', text: 'Log in'

        #fill in fields
        find('#user_email').fill_in with: @email
        find('#user_password').fill_in with: @pass
        find('input[value="Log in"]').click
#puts page.html
        assert page.has_text?('Signed in successfully.'), 'Successful sign in flash not present'
        
        #assert redirect to admin panel
        assert page.has_text?('Welcome to Active Admin. This is the default dashboard page.'), 'Sign in did not redirect to ActiveAdmin page'
        
        #assert logout takes back to original view
        visit '/'
        assert page.has_text?('Add Dish to Menu', count: 1), 'Add dish button not present for logged in admin user'
#puts page.html
        find('a[href="/users/sign_out"]').click
        assert page.has_text?('Signed out successfully.'), 'Sign out flash not present'
        assert page.has_text?('Add Dish to Menu', count: 0), 'Add dish button present after logout'
    end

end
