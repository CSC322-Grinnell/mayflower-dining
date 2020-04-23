require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @staff = User.new(email: "email@email.com", password:"password",
                      password_confirmation: "password", name:"Staff",
                      admin: false)
    @admin = User.new(email: "email2@email.com", password:"password",
                      password_confirmation: "password", name:"Staff",
                      admin: true)
  end

  test "setup staff valid" do
    assert @staff.valid?
  end

  test "setup admin valid" do
    assert @admin.valid?
  end

  test "password should be at least 3 characters" do
    @staff.password = "ab"
    @staff.password_confirmation = "ab"
    assert_not @staff.valid?
  end

  test "need password confirmation" do
    @staff.password_confirmation = ""
    assert_not @staff.valid?
  end

  test "password confirmation must match" do
    @admin.password_confirmation = "password1"
    assert_not @admin.valid?
  end

  test "admin setter works with bool" do
    assert_not @staff.admin
    assert @admin.admin
  end

  test "admin setter works with string 'Staff' " do
    @staff.admin = "Staff"
    assert_not @staff.admin
  end

  test "admin setter works with string 'Admin' " do
    @admin.admin = "Admin"
    assert @admin.admin
  end
end
