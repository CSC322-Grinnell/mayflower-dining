require 'test_helper'

class DishTest < ActiveSupport::TestCase

    test 'add dish' do
        dish = Dish.create({name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving"})
        assert dish.valid?
    end

    test 'get dish success' do
        dish = Dish.get_dish("french toast")
        assert_equal(dish, Dish.where(name:"french toast").first)
    end

    test 'get dish fail' do
        assert_raise ArgumentError do
          dish = Dish.get_dish("non exist")
        end
    end

    test 'remove dish fail' do
        assert_raise ArgumentError do
          dish = Dish.remove_dish("non exist")
        end
    end

    test 'remove dish success' do
        dish = Dish.get_dish("french toast")
        dish = Dish.remove_dish("french toast")
        assert_not Dish.exists?(dish.id)
    end

end
