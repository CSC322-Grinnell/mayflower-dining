require 'test_helper'

class TemporaryMenuTest < ActiveSupport::TestCase
  test "add_dishes" do
    test_date = Date.new(2019, 2, 8)
    start_date = Date.new(2018, 12, 2)
    day_in_cycle = (test_date - start_date) % 49
    menu = Menu.where(day: day_in_cycle)[0]
    dish = Dish.create
    dish2 = Dish.create
    dish3 = Dish.create
    dish4 = Dish.create
    dish5 = Dish.create
    temp_menu = TemporaryMenu.add_dishes(test_date,  [dish,dish2,dish3,dish4,dish5])
    assert temp_menu.valid?
    assert_equal((menu.dishes.length+ 5), temp_menu.dishes.length)
  end
  
  test 'copy_to_temp_menu' do
    test_date = Date.new(2019, 2, 8)
    day_in_cycle = 19
    temp_menu = TemporaryMenu.copy_to_temp_menu(day_in_cycle, test_date)
    menu = Menu.where(day: day_in_cycle)[0]
    assert temp_menu.valid?
    assert_equal(test_date,temp_menu.date)
    # assert_equal('Entree',menu.type_of_meal)
    assert_equal(menu.dishes.length, temp_menu.dishes.length)
      
  end
  
   
  
end
