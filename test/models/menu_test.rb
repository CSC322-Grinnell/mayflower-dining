require 'test_helper'
require "time"

class MenuTest < ActiveSupport::TestCase

    test 'validate menu through get menu' do
        assert_raise ArgumentError do
            Menu.validate_menu(0, "something")
        end
        assert_raise ArgumentError do
            Menu.validate_menu(100, "something")
        end
        assert_raise ArgumentError do
            Menu.validate_menu(1, "Dunner")
        end
        assert_raise ArgumentError do
          Menu.validate_menu(45, "Lonch")
        end
    end

    test 'get menu' do
        m = Menu.get_menu(15, "Breakfast")
        assert_equal(m, Menu.where(day:15, type_of_meal: "Breakfast").first)
    end

    test 'add dishes to cycle' do
        dishes = []
        dishes.push(Dish.get_dish("rando"))
        dishes.push(Dish.get_dish("two"))
        Menu.add_dishes_to_cycle(1,"Breakfast", dishes)
        m = Menu.get_menu(1, "Breakfast")
        assert DishMenu.exists?(dish_id:Dish.get_dish("rando").id, menu_id:m.id)
        assert DishMenu.exists?(dish_id:Dish.get_dish("two").id, menu_id:m.id)
    end

    test 'add dish to cycle' do
        Menu.add_dish_to_cycle(1, "Breakfast" , Dish.get_dish("rando"))
        m = Menu.get_menu(1, "Breakfast")
        assert DishMenu.exists?(dish_id:Dish.get_dish("rando").id, menu_id:m.id)
    end

    test 'get dishes by day type' do
      dishes = []
      dishes.push(Dish.get_dish("rando"))
      dishes.push(Dish.get_dish("two"))
      Menu.add_dishes_to_cycle(1, "Breakfast", dishes)
      Menu.get_dishes_by_day_type(1, "Breakfast").each do |r|
        assert Dish.exists?(r.dish_id)
      end
    end

    test 'get dishes by date type' do
      dishes = []
      dishes.push(Dish.get_dish("two"))
      dishes.push(Dish.get_dish("rando"))
      Menu.add_dishes_to_cycle(1,"Breakfast", dishes)
      lst = Menu.get_dishes_by_date_type("2019-12-8", "Breakfast").order(:dish_id)
      assert_equal lst[0].dish_id, Dish.get_dish("two").id
      assert_equal lst[0].menu_id, Menu.get_menu(1, "Breakfast").id
      assert_equal lst[1].dish_id, Dish.get_dish("rando").id
      assert_equal lst[1].menu_id, Menu.get_menu(1, "Breakfast").id
    end

    test 'remove_dish' do
      dishes = []
      dishes.push(Dish.get_dish("rando"))
      dishes.push(Dish.get_dish("two"))
      dishes.push(Dish.get_dish("one"))
      m = Menu.add_dishes_to_cycle(1,"Breakfast", dishes)
      assert DishMenu.exists?(dish_id:Dish.get_dish("rando").id, menu_id:m.id)
      assert DishMenu.exists?(dish_id:Dish.get_dish("two").id, menu_id:m.id)
      assert DishMenu.exists?(dish_id:Dish.get_dish("one").id, menu_id:m.id)
      Menu.remove_dish_by_day_type(Dish.get_dish("two"), 1, "Breakfast")
      Menu.get_dishes_by_day_type(1, "Breakfast").each do |r|
          assert_not_equal r.dish_id , Dish.get_dish("two").id
      end
    end

end
