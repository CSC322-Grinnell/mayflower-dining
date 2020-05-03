ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "#{Rails.root}/db/seeds.rb"
require 'date'
require "minitest/rails/capybara"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_user(email='admin@example.com', password='password')
    post '/sessions', params: {email: email, password: password}
#    follow_redirect!
  end

  def logout_user
    delete '/log_out'
#    follow_redirect!
  end
end
