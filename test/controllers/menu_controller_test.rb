require 'test_helper'

class MenuControllerTest < ActionDispatch::IntegrationTest
    
    setup do
        @date = "2020-04-18"
    end

    test "get daily menu" do
        get root_url
        assert_response :success
        assert_select 'h1', 'Menu for Today'
    end

    test "edit menu add" do
        skip "Feature not yet implemented"

        # check that dish to add does not already exist in menu
        get "/menu/#{@eate}"
        assert_response :success
        assert_select 'td', text: 'Gravy', count: 0
        # add dish to menu
        get "/menu/edit/#{@date}/add/gravy"
        assert_response :redirect
        # check that dish was correctly added to menu
        get "/menu/#{@date}"
        assert_select 'td', 'Ham'
        assert_select 'td', 'Gravy'
    end

    test "edit menu remove" do
        skip "Feature not yet implemented"

        # check that dish to remove already exists in menu
        get "/menu/#{@date}"
        assert_response :success
        assert_select 'td', text: 'Ham', count: 1
        # add dish to menu
        get "/menu/edit/#{@date}/remove/ham"
        assert_response :redirect
        # check that dish was correctly removed from menu
        get "/menu/#{@date}"
        assert_response :success
        assert_select 'td', text: 'Ham', count: 0
    end

    test "date routing" do
        skip "Routing w/o the calendar doesnt change date yet"

        get "/menu/#{@date}"
        assert_response :success
        assert_select "#date", "Sat Apr 18 2020"
    end
end
