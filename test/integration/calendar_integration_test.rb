require 'test_helper'
require "#{Rails.root}/app/helpers/menu_helper"

class CalendarIntegrationTest < Capybara::Rails::TestCase
    include MenuHelper

    setup do
        Capybara.current_driver = :selenium_chrome_headless
    end

    teardown do
        Capybara.use_default_driver
    end


    test "calendar present" do
        visit '/'
        assert find('#calendar'), "Calendar not found"
        assert find('td.day.active.today'), "Calendar not found"
    end

    test "only one calendar" do
        visit '/'
        #check only 1 calendar present
        assert page.has_css?('td.day.active.today', count: 1), "Non 1 number of calendars on initial page load"

        #click staff login and then navigate back
        find('a[href="/log_in"]').click
        assert page.has_text?('Log In'), "Did not navigate to login page"
        page.driver.go_back
        assert page.has_text?('Menu for Today')

        #check that still only 1 calendar
        assert page.has_css?('td.day.active.today', count: 1), "Non 1 number of calendars after back navigation"
    end

    test "calendar date navigation" do
        visit '/'
        #test that clicked day changes date h1
        today = page.find('td.day.active.today')['data-day'].split('/')
        if today[1] == '01'
            # make the click date the 2nd
            today[1] = '02'
            other_date = today.join('/')
        else
            #make the click date the first
            today[1] = '01'
            other_date = today.join('/')
        end
        page.find('td.day[data-day="' + other_date + '"]').click
        assert page.has_text?('Menu for Today', count: 0), 'Clicking calendar didnt change date heading text'

        #test that highlighted day changed
        assert page.find('td.day.active[data-day="' + other_date + '"]'), 
                    'Active day on calendar didnt change'

        #test that all db info for correct day is displayed
        formated_date = other_date.split('/')
        formated_date = [formated_date[1],formated_date[0],formated_date[2]].join('/')
        error, dishes = find_dishes(formated_date)
        
        for dish in dishes do
            assert page.has_text?(dish.strip), "Dish #{dish} wasn't present on page"
        end
    end

    test "todays menu button updates calendar" do
        visit '/'
        #navigate to some other date
        today = page.find('td.day.active.today')['data-day'].split('/')
        if today[1] == '01'
            # make the click date the 2nd
            today[1] = '02'
            other_date = today.join('/')
        else
            #make the click date the first
            today[1] = '01'
            other_date = today.join('/')
        end
        page.find('td.day[data-day="' + other_date + '"]').click
        assert page.has_text?('Menu for Today', count: 0), 'Clicking calendar didnt change date heading text'

        #click todays menu button
        click_link "See today's menu"

        #test menu date h1 is correct
        assert_selector 'h1', text: "Menu for Today"

        #test today is highlighted on calendar
        assert page.has_css?('td.day.active.today'), 'Today on calendar wasnt active'

        #test menu contents match db
        date = find('td.day.active.today')['data-day'].split('/')
        formated_date = [date[1],date[0],date[2]].join('/')
        error, dishes = find_dishes(formated_date)
        
        for dish in dishes do
            assert page.has_text?(dish.strip), "Dish #{dish} wasn't present on page"
        end
    end
end
