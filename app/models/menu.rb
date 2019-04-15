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
        if self.where(:day => day_in_cycle.to_s).empty?
            menu = self.create(day: day_in_cycle)
        else  
            menu = self.where(:day => day_in_cycle.to_s).first
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
    
    def self.get_dishes_by_id(day_in_cycle)
        Menu.where(day: day_in_cycle)[0].dishes
    end
    
    def self.get_dishes_by_date(date)
        start_date = Date.parse("27/3/2019")
        begin
            end_date = Date.parse(date)
        rescue ArgumentError
            return
        end
        
        day_in_cycle = (end_date - start_date) % 70
        menu = Menu.where(day: day_in_cycle)[0]
        if menu != nil
            menu.dishes.select(:name)
        end
        
    end
    
    # Purpose:
    # output an sorted array that contains multiple arrays that have the 
    # name of the ingredient at index 0 and the amount of the ingredient 
    # at index 1. The ingredients are from the dishes of the input "data"
    def self.get_ingredients_by_date(date)
        # dishes_array is a 3d array 
        dishs_array =self.get_dishes_by_id(date);
        if dishs_array !=nil
            # ingredients_array is a 2d array with each ingredients as an array
            ingredients_array = dishs_array.map { |dish|
                                    dish.ingredients.map { |ingredient|
                                        ingredient
                                        }.flatten
                                    }.flatten
            # go through each array 
            ingredients_array.each do |ingredient|
                # add the array into the new_dish_array 
                new_dish_array.push(ingredient.select(:name,:portion_size))
            end 
            sorted_array=new_dish_array.sort{|a,b| a[0]<=>b[0]}
        else
            sorted_array = []
        end 
        
        return sorted_array
    end 
        
end