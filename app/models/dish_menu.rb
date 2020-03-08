class DishMenu < ApplicationRecord
    self.table_name = "dishes_menus"
    belongs_to :dish

    validates :day, presence: true,
        :inclusion => 0..48

    def self.add_dish_to_cycle(day, dish)
        if !DishMenu.exists?(dish_id:dish.id, day:day)
            DishMenu.create!(dish_id:dish.id, day:day)
        end
    end

    def self.remove_dish_from_cycle(day, dish)
        entry=DishMenu.get_dish_menu(dish_id:dish.id,day:day)
        entry.destroy
        entry
    end

    private 
end
