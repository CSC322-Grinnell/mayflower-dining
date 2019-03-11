class Menu < ApplicationRecord
    has_many :dishes
    validates :day, presence: true
    
    
    # Purpose:
    #   Adds dishes to the appropriate day in the cycle (in Menu database)
    #   If specified day does not exist creates a new day, 
    #       else adds new dishes to the Menu record with the given day
    # Params: 
    #   day_in_cycle:a day between 1 - 49, representin a day in the cycle
    #                ie. Week 1, Day 1 = 1; Week 3, Day 5 = ,19
    #   dishes: an array of dishes to be served that day
    def self.add_dishes_to_cycle(day_in_cycle, dishes)
        if self.where(day = day_in_cycle.to_s).length == 0
            menu = self.create(day: day_in_cycle)
        else  
            menu = self.where(day = day_in_cycle.to_s)[0]
        end
            
        dishes.each do |dish|
            menu.dishes.append(dish)
            dish.menu = menu 
        end
        
        menu
    end
    
    # Purpose:
    #   Makes a copy of the dishes in a given day of the cycle from Menu and
    #       stores it under the given date in the temporary menu.
    #   This is so that the data needed for the temporary change is available 
    # Params: 
    #   day_in_cycle:a day between 1 - 49, representin a day in the cycle
    #                ie. Week 1, Day 1 = 1; Week 3, Day 5 = ,19
    #   date: a ruby date of which the dishes should  be stored under in the
    #         temporary menu 
    def self.copy_to_temp_menu(day_in_cycle,date)
        true
    end
        
end
