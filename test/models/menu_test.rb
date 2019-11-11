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
        m = Menu.get_menu(1, "Breakfast")
        m.dish_ids = [1]
        m.save
        assert([1], Menu.get_menu(1, "Breakfast").dish_ids)
        dishes = []
        dishes.push(Dish.get_dish("rando"))
        dishes.push(Dish.get_dish("two"))
        Menu.add_dishes_to_cycle(1,"Breakfast", dishes)
        assert_equal([1,12,2], Menu.get_menu(1, "Breakfast").dish_ids)
        assert_equal(Menu.get_menu(1, "Breakfast").id, Dish.get_dish("two").menu_id)
        assert_equal(Menu.get_menu(1, "Breakfast").id, Dish.get_dish("rando").menu_id)
    end

    test 'add dish to cycle' do
        m = Menu.get_menu(1, "Breakfast")
        m.dish_ids = [1]
        m.save
        assert([1], Menu.get_menu(1, "Breakfast").dish_ids)
        Menu.add_dish_to_cycle(1, "Breakfast" , Dish.get_dish("rando"))
        assert_equal([1,12], Menu.get_menu(1, "Breakfast").dish_ids)
        assert_equal(Menu.get_menu(1, "Breakfast").id, Dish.get_dish("rando").menu_id)
    end

    test 'get dishes by day type' do
      dishes = []
      dishes.push(Dish.get_dish("rando"))
      dishes.push(Dish.get_dish("two"))
      Menu.add_dishes_to_cycle(1,"Breakfast", dishes)
      assert_equal([12,2], Menu.get_dishes_by_day_type(1, "Breakfast"))
    end

    test 'get dishes by date type' do
      dishes = []
      dishes.push(Dish.get_dish("rando"))
      dishes.push(Dish.get_dish("two"))
      Menu.add_dishes_to_cycle(1,"Breakfast", dishes)
      assert_equal([12,2], Menu.get_dishes_by_date_type("2019-12-8", "Breakfast"))
    end

    test 'remove_dish' do
      dishes = []
      dishes.push(Dish.get_dish("rando"))
      dishes.push(Dish.get_dish("two"))
      dishes.push(Dish.get_dish("one"))
      Menu.add_dishes_to_cycle(1,"Breakfast", dishes)
      assert_equal([12,2,1], Menu.get_dishes_by_day_type(1, "Breakfast"))
      assert_equal(Menu.get_menu(1, "Breakfast").id, Dish.get_dish("one").menu_id)
      Menu.remove_dish(Dish.get_dish("two"))
      assert_equal([12,1], Menu.get_dishes_by_day_type(1, "Breakfast"))
      assert_not Menu.exists?(Dish.get_dish("one").menu_id)
    end

end
