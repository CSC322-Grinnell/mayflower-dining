require 'test_helper'

class DishTest < ActiveSupport::TestCase

    test 'add dish success' do
        dish = Dish.add_dish(name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving")
        assert dish.valid?
    end

    test 'add dish fail' do
        Dish.add_dish(name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving")
        assert_raise ArgumentError do
            Dish.add_dish(name= "french toast", star= 3, mesh_soft=2, puree="", portion_size="", diet="1/2 serving")
        end
    end

    test 'get dish success' do
        Dish.add_dish(name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving")
        dish = Dish.get_dish("french toast")
        assert_equal(dish, Dish.where(name:"french toast").first)
        id = dish.id
        dish = Dish.get_dish(id)
        assert_equal(dish, Dish.where(name:"french toast").first)
    end

    test 'update dish success' do
        Dish.add_dish(name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving")
        dish = Dish.get_dish("french toast")
        Dish.update_dish(name:"french toast",portion_size:"1 / 2 size")
        dish = Dish.get_dish("french toast")
        assert_equal(dish.portion_size, "1 / 2 size")
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
        Dish.add_dish(name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving")
        dish = Dish.get_dish("french toast")
        dish = Dish.remove_dish("french toast")
        assert_not Dish.exists?(dish.id)
    end

end
