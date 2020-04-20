require 'test_helper'
require "time"

class DishMenuTest < ActiveSupport::TestCase

    test 'add dish to cycle' do
        dish = Dish.create({name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving"})
        DishMenu.add_dish_to_cycle(0,dish)
        assert DishMenu.exists?(dish_id:Dish.get_dish("french toast").id)
    end

    test 'get menu' do
        dish = Dish.create({name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving"})
        DishMenu.add_dish_to_cycle(48,dish)
        menu=DishMenu.get_menu(48)
        assert menu.length()==1
    end

    test 'remove dish day entry' do
        dish = Dish.create({name: "french toast", star: 3, mesh_soft:2, puree:"", portion_size:"", diet:"1/2 serving"})
        DishMenu.add_dish_to_cycle(0,dish)
        DishMenu.remove_dish_from_cycle(0,Dish.get_dish("french toast"))
        assert_not DishMenu.exists?(dish_id:Dish.get_dish("french toast").id)
    end

end
