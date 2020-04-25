require 'test_helper'
require "time"

class DishMenuTest < ActiveSupport::TestCase

    test 'add dish to cycle' do
        Dish.add_dish(name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving")
        DishMenu.add_dish_to_cycle(0,"french toast")
        assert DishMenu.exists?(dish_id:Dish.get_dish("french toast").id)
    end

    test 'add dish to cycle fail' do
        assert_raise ArgumentError do
            DishMenu.add_dish_to_cycle(0,"non exist")
        end
    end

    test 'get menu' do
        old_len = DishMenu.get_menu(48).length()
        Dish.add_dish(name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving")
        DishMenu.add_dish_to_cycle(48,"french toast")
        menu=DishMenu.get_menu(48)
        assert menu.length() == old_len+1
    end

    test 'update dish menu' do
        Dish.add_dish(name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving")
        DishMenu.add_dish_to_cycle(0,"french toast")
        DishMenu.update_dish_menu(day:0,name:"french toast",bb_prep:"1000")
        entry = DishMenu.get_dish_menu(0,"french toast")
        assert_equal(entry.bb_prep,"1000")
    end

    test 'remove dish day entry' do
        Dish.add_dish(name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving")
        DishMenu.add_dish_to_cycle(0,"french toast")
        DishMenu.remove_dish_from_cycle(0,"french toast")
        assert_not DishMenu.exists?(dish_id:Dish.get_dish("french toast").id)
    end

end
