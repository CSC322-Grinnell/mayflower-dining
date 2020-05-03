require 'test_helper'

class LoginIntegrationTest < Capybara::Rails::TestCase

    setup do
        @admin_email = 'admin@example.com'
        @staff_email = 'staff@example.com'
        @pass = 'password'
    end

    teardown do
    end

    test "login and logout user flow" do
        visit '/'
        assert_selector 'h1', text: 'Menu for Today'

        find('a[href="/log_in"]').click
        assert_selector 'h1', text: 'Log In'

        #fill in fields
        find('#email').fill_in with: @admin_email
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
        visit '/'
        assert_selector 'h1', text: 'Menu for Today'

        find('a[href="/log_in"]').click
        assert_selector 'h1', text: 'Log In'

        #fill in fields
        find('#email').fill_in with: @admin_email
        find('#password').fill_in with: @pass
        find('input[value="Log In"]').click

        #assert redirect to root url
        assert page.has_text?('Welcome back!'), 'Successful sign in flash not present'
        assert_current_path '/'

        #check admin capabilities present
        assert page.has_text?('Add Dish to Menu', count: 1), 'Add dish button not present for admin user'
        assert page.has_text?('Admin Tasks', count: 1), 'Admin panel button not present for admin'
        assert page.has_text?('TEMP remove dish'), 'Temp dish removal not an option for admin'
        assert page.has_text?('PERM remove dish'), 'Permanent dish removal not an option for admin'
        
        #assert logout takes back to original view
        find('a[href="/log_out"]').click
        assert page.has_text?('See you!'), 'Sign out flash not present'
        assert page.has_text?('Add Dish to Menu', count: 0), 'Add dish button present after logout'
    end

    test "staff user views dont have admin features" do
        visit '/'
        assert_selector 'h1', text: 'Menu for Today'

        find('a[href="/log_in"]').click
        assert_selector 'h1', text: 'Log In'

        #fill in fields
        find('#email').fill_in with: @staff_email
        find('#password').fill_in with: @pass
        find('input[value="Log In"]').click

        #assert redirect to root url
        assert page.has_text?('Welcome back!'), 'Successful sign in flash not present'
        assert_current_path '/'

        #check admin capabilities present
        assert page.has_text?('Add Dish to Menu', count: 0), 'Add dish button present for staff user'
        assert page.has_text?('Admin Tasks', count: 0), 'Admin panel button present for staff'
        assert !page.has_text?('TEMP remove dish'), 'Temp dish removal an option for staff'
        assert !page.has_text?('PERM remove dish'), 'Permanent dish removal an option for staff'
        
        #assert logout takes back to original view
        find('a[href="/log_out"]').click
        assert page.has_text?('See you!'), 'Sign out flash not present'
        assert page.has_text?('Add Dish to Menu', count: 0), 'Add dish button present after logout'
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
