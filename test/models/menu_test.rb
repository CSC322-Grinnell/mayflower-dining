require 'test_helper'
require "time"

class MenuTest < ActiveSupport::TestCase

    test 'add dish to cycle' do
        Dish.add_dish(name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving")
        Menu.add_dish_to_cycle(0,"french toast")
        assert Menu.exists?(dish_id:Dish.get_dish("french toast").id)
    end

    test 'add dish to cycle fail' do
        assert_raise ArgumentError do
            Menu.add_dish_to_cycle(0,"non exist")
        end
    end

    test 'get menu' do
        old_len = DishMenu.get_by_day(48).length()
        Dish.add_dish(name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving")
        Menu.add_dish_to_cycle(48,"french toast")
        menu=Menu.get_by_day(48)
        assert menu.length()==old_len+1
    end

    test 'update dish menu' do
        Dish.add_dish(name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving")
        Menu.add_dish_to_cycle(0,"french toast")
        Menu.update_menu(day:0,name:"french toast",bb_prep:"1000")
        entry = Menu.get_by_day_and_dish(0,"french toast")
        assert_equal(entry.bb_prep,"1000")
    end

    test 'remove dish day entry' do
        Dish.add_dish(name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving")
        Menu.add_dish_to_cycle(0,"french toast")
        Menu.remove_dish_from_cycle(0,"french toast")
        assert_not Menu.exists?(dish_id:Dish.get_dish("french toast").id)
    end

end
