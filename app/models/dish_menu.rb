class DishMenu < ApplicationRecord
    self.table_name = "dishes_menus"
    belongs_to :dish

    validates :day, presence: true,
        :inclusion => 0..48

    def self.get_menu(day)
        raise ArgumentError, "Day out of range." unless 0<=day && day<=48
        entries=self.where(day:day)
        entries
    end

    def self.get_dish_menu(day, dish)
        entry=self.where(dish_id:dish.id, day:day)
        raise ArgumentError, "Entry doesn't exist." unless !entry.empty?
        entry.first
    end

    def self.add_dish_to_cycle(day, dish)
        if !DishMenu.exists?(dish_id:dish.id, day:day)
            DishMenu.create!(dish_id:dish.id, day:day)
        end
    end

    def self.remove_dish_from_cycle(day, dish)
        entry=DishMenu.get_dish_menu(day, dish)
        entry.destroy
        entry
    end

    private
end
