require 'test_helper'

class UserManagementIntegrationTest < Capybara::Rails::TestCase
	setup do
        @admin_email = 'admin@example.com'
        @staff_email = 'staff@example.com'
        @pass = 'password'
        #setup chrome driver for access to click js popups
        Capybara.current_driver = :selenium_chrome_headless
    end

    teardown do
    	Capybara.use_default_driver
    end

    test "user management panel" do
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

        #go to admin tasks and check that all tasks are present
        find('a[href="/admin"]').click
        assert page.has_text?('Admin Tasks Page'), "Did not arrive at admin tasks page"
        assert page.has_text?('User Management'), "User management link not present"
        assert page.has_text?('Menu Page'), "Menu page navigation button not present"

        click_link 'User Management'
        assert page.has_text?('User Management'), "User manage button did not link to user manage panel"
        assert_current_path '/admin/management'

        #assert all users show up in panel
        for user in User.all do
            assert page.has_text?(user.name.strip), "User was not present in admin panel"
        end

        #navigate back to root path
        find('a[href="/admin"]').click
        assert page.has_text?('Admin Tasks Page'), "Did not navigate back to tasks page"

        click_link 'Menu Page'
        assert page.has_text?('Menu for Today'), "Menu Page button did not link back to root"
        assert_current_path '/'

        #assert logout takes back to original view
        find('a[href="/log_out"]').click
        assert page.has_text?('See you!'), 'Sign out flash not present'
        assert page.has_text?('Add Dish to Menu', count: 0), 'Add dish button present after logout'
    end

    test "create, edit, destroy user success" do
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

        #go to admin tasks and check that all tasks are present
        find('a[href="/admin"]').click
        assert page.has_text?('User Management'), "User management link not present"

        click_link 'User Management'
        assert page.has_text?('User Management'), "User manage button did not link to user manage panel"
        assert_current_path '/admin/management'

        #create a new user
        find('a[href="/users/new"]').click
        find('#user_name').fill_in with: 'Testy'
        find('#user_email').fill_in with: 'a@a.com'
        find('#user_password').fill_in with: 'safe'
        find('#user_password_confirmation').fill_in with: 'safe'
        find('#user_admin').find('option[value="Staff"]').select_option
        find('input[value="Create User"]').click
        #check created successfully
        assert page.has_text?('Welcome!'), "Successful user creation flash not present"
        assert_current_path '/admin/management'
        assert page.has_text?('Testy'), "User was not present in admin panel"
        new_user = User.find_by(name: 'Testy')
        assert !new_user.nil?, 'New user was not in the database'

        #edit the new user
        find('a[href="/users/' + new_user.id.to_s + '/edit"]').click
        assert page.has_css?('input[value="Update User"]'), "Update user was not present on edit page"
        find('#user_name').fill_in with: 'Tester'
        find('#user_email').fill_in with: 'a@a.com'
        find('#user_password').fill_in with: 'safe'
        find('#user_password_confirmation').fill_in with: 'safe'
        find('#user_admin').find('option[value="Staff"]').select_option
        find('input[value="Update User"]').click
        #check updated successfully
        assert page.has_text?('Tester'), "Updated user name not shown"

        #destroy the new user, and click the confirmation popup
        accept_confirm do
            find('a[href="/users/' + new_user.id.to_s + '"]').click
        end
        #confirm user destroyed
        assert page.has_text?('Tester', count: 0), "Deleted user name still present on admin panel"

        #assert logout takes back to original view
        find('a[href="/"]').click
        assert page.has_text?('Menu for Today'), "Did not navigate back to root path from admin panel"
        find('a[href="/log_out"]').click
        assert page.has_text?('See you!'), 'Sign out flash not present'
        assert page.has_text?('Add Dish to Menu', count: 0), 'Add dish button present after logout'
    end

    test "admin cannot remove itself" do
        # login as admin
        visit '/'
        find('a[href="/log_in"]').click
        find('#email').fill_in with: @admin_email
        find('#password').fill_in with: @pass
        find('input[value="Log In"]').click

        #assert redirect to root url
        assert page.has_text?('Welcome back!'), 'Successful sign in flash not present'
        assert_current_path '/'

        #go to user management
        find('a[href="/admin"]').click
        click_link 'User Management'
        assert page.has_text?('User Management'), "User manage button did not link to user manage panel"
        assert_current_path '/admin/management'

        #try to delete self
        accept_confirm do
            find('a[href="/users/' + User.find_by(email: @admin_email).id.to_s + '"]').click
        end
        #confirm user not destroyed
        assert page.has_text?(@admin_email, count: 1), "Admin was able to delete itself"
        assert page.has_text?("You can't delete yourself!"), "Failed deletion flash not present"
    end

end