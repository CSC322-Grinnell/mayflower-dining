require 'test_helper'

class DishTest < ActiveSupport::TestCase

    test 'add dish' do
        recipes =[]
        dish = Dish.add_dish("new", recipes)
        assert dish.valid?
    end

    test 'add dish with recipes' do
      recipes = [["one", "something"], ["two", "something else"]]
      dish = Dish.add_dish("new", recipes)
      assert dish.valid?

      recipes = Recipe.get_recipe_by_dish(dish)

      recipes.each do |recipe|
        assert recipe.valid?
      end
    end

    test 'get dish success' do
        dish = Dish.get_dish("one")
        assert_equal(dish, Dish.where(name:"one").first)
    end

    test 'get dish fail' do
        assert_raise ArgumentError do
          dish = Dish.get_dish("three")
        end
    end

    test 'remove dish fail' do
        assert_raise ArgumentError do
          dish = Dish.remove_dish("one")
        end
    end

    test 'remove dish success' do
        # TODO: fix the next 2 lines
        # The fixture currently does not like nil
        dish = Dish.get_dish("two")
        dish.save
        dish = Dish.remove_dish("two")
        assert_not Dish.exists?(dish.id)
    end

end
