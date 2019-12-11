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

end
