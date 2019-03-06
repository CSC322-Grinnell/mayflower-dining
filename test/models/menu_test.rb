require 'test_helper'

class MenuTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
    test 'add_to_cycle' do
        menu = Menu.new()
        assert menu.valid?
    end
  
end