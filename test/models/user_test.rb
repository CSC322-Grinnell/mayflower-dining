require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test 'valid user' do
    user = User.new(email: 'john@example.com')
    refute user.valid?
  end

  test 'invalid without name' do
    user = User.new(email: 'john@example.com')
    refute user.valid?, 'user is valid without a name'
  end

  test 'invalid without email' do
    user = User.new(encrypted_password: '68gf3749gtq3rg4bq34g79q3')
    refute user.valid?
    assert_not_nil user.errors[:email]
  end
  
end
