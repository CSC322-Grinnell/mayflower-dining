class Menu < ApplicationRecord
    self.table_name = "menus"
    belongs_to :dish

    validates :day, presence: true,
        :inclusion => 0..48

    def self.get_by_day(day) #get all the dishes for a day
        raise ArgumentError, "Day out of range." unless 0<=day && day<=48
        entries=self.where(day:day)
        entries
    end

    def self.get_by_day_and_dish(day, name)
        dish = Dish.get_dish(name)
        entry=self.where(dish_id:dish.id, day:day)
        raise ArgumentError, "Entry doesn't exist." unless !entry.empty?
        entry.first
    end

    def self.add_dish_to_cycle(day, name)
        dish = Dish.get_dish(name)
        if !Menu.exists?(dish_id:dish.id, day:day)
            Menu.create!(dish_id:dish.id, day:day, hc_prep:"111", hc_leftover:"", bb_prep:"", bb_leftover:"", buckley_prep:"", buckley_leftover:"")

        end
    end
    
    # update prep / leftover for an entry
    def self.update_menu(day:, name:, hc_prep:nil, hc_leftover:nil, bb_prep:nil, bb_leftover:nil, buckley_prep:nil, buckley_leftover:nil)
        entry=Menu.get_by_day_and_dish(day, name)
        entry.hc_prep = (hc_prep == nil ? entry.hc_prep : hc_prep)
        entry.hc_leftover = (hc_leftover == nil ? entry.hc_leftover: hc_leftover)
        entry.bb_prep = (bb_prep == nil ? entry.bb_prep : bb_prep)
        entry.bb_leftover = (bb_leftover == nil ? entry.bb_leftover: bb_leftover)
        entry.buckley_prep = (buckley_prep == nil ? entry.buckley_prep : buckley_prep)
        entry.buckley_leftover = (buckley_leftover == nil ? entry.buckley_leftover: buckley_leftover)
        entry.save
        entry
    end

    def self.remove_dish_from_cycle(day, name)
        entry=Menu.get_by_day_and_dish(day, name)
        entry.destroy
        entry
    end

    private
end
