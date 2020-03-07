class DishMenu < ApplicationRecord
    self.table_name = "dishes_menus"
    belongs_to :dish

    validates :day, presence: true,
        :inclusion => 0..48

    def self.add_dish_to_cycle(day, dish)
        DishMenu.create!(dish_id:dish.id, day:day)
    end

    private 
end
