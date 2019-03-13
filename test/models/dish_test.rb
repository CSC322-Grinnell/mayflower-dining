require 'test_helper'

class DishTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
    test 'add dish' do
        dish = Dish.new
        assert dish.valid?
    end
  
    test 'add dish (as child of Menu)' do
      # can different days in the menu have the same dish?
        menu = Menu.new(day: 1, dish_id: 1, type_of_meal: 'Entree')
        assert menu.valid?
        menu.save()
        dish = Dish.new
        dish.menu = menu
        menu.dishes.append(dish)
        assert dish.valid?
        assert_equal(1,menu.dishes.length) 
    end
    
    test 'add dish (not as child of Menu)' do
        dish = Dish.new
        assert dish.valid?
    end
    
    test 'add_ingredients_by_id ' do
        dish = Dish.new
        ing1 = Ingredient.new
        ing2 = Ingredient.new
        ing3 = Ingredient.new
        ing4 = Ingredient.new
        Dish.add_ingredients_by_id(dish,[ing1, ing2, ing3, ing4])
        assert_equal([ing1, ing2, ing3, ing4],dish.ingredients)
    end 
    
    
    
    
    
end
