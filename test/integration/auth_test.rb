require 'test_helper'

class AuthTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

    test "visit home unauthenticated" do
        get "http://localhost/"
        assert_response 200
    end


    test "visit menu unauthenticated" do
      get "http://localhost/menu"
      assert_response 200
    end


    test "visit add_item unauthenticated" do
      get "http://localhost/pages/add_item"
      assert_response 302
    end

    test "visit dish url unauthenticated" do
      post "http://localhost/dish/add_to_cycle"
      assert_response 302
      post "http://localhost/dish/add_to_temp"
      assert_response 302
      get "http://localhost/dish/add_to_temporary_menu"
      assert_response 302
    end
    

    test "visit temporary menus urls unauthenticated" do
      get "http://localhost/temp"
      assert_response 302   
    end

    test "visit permanent edits unauthenticated" do
      get "http://localhost/permanent_edit"
      assert_response 302   
    end

    test "visit prep page unauthenticated" do
      get "http://localhost/prep/prep_page"
      assert_response 302   
    end

    test "visit home authenticated" do
      sign_in users(:one)
      get "http://localhost/"
      assert_response 200
    end
    
    test "visit menu authenticated" do
      sign_in users(:one)
      get "http://localhost/menu"
      assert_response 200
    end


    test "visit add_item authenticated" do
      sign_in users(:one)
      get "http://localhost/pages/add_item"
      assert_response 200
    end

    test "visit dish url authenticated" do
      sign_in users(:one)
      post "http://localhost/dish/add_to_cycle"
      assert_response 200
      post "http://localhost/dish/add_to_temp"
      assert_response 200
      get "http://localhost/dish/add_to_temporary_menu"
      assert_response 200
    end
    

    test "visit temporary menus urls authenticated" do
      sign_in users(:one)
      get "http://localhost/temp"
      assert_response 200  
    end

    test "visit permanent edits authenticated" do
      sign_in users(:one)
      get "http://localhost/permanent_edit"
      assert_response 200  
    end

    test "visit prep page authenticated" do
      sign_in users(:one)
      get "http://localhost/prep/prep_page"
      assert_response 200  
    end


end
