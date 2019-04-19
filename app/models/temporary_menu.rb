class TemporaryMenu < ApplicationRecord
    has_many :dishes
    
    # incomplete documentation
    # Purpose:
    #
    # Params:
    #   date:
    #   dishes: 
    def self.add_dishes(date, dishes)
        start_date = Date.new(2018, 12, 8)
        day_in_cycle = (date - start_date) % 49
        
        if self.where(:date => date).empty?
            temporary_menu = self.copy_to_temp_menu(day_in_cycle, date)
        else  
            temporary_menu = self.where(:date => date).first
        end
            
        dishes.each do |dish|
            temporary_menu.dishes.append(dish)
            dish.temporary_menu = temporary_menu 
        end
        
        temporary_menu
    end
    
    # incomplete 
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
        if self.where(:date => date.to_s).empty?
            temporary_menu = self.create(date: date)
        else  
            temporary_menu = self.where(:date => date).first
        end
        
        menu = Menu.where(:day => day_in_cycle)[0]
        dishes =  menu.dishes
            
        dishes.each do |dish|
            
            # duplicate dishes
            dish_cpy = dish.dup
            temporary_menu.dishes.append(dish)
            dish_cpy.temporary_menu = temporary_menu 
            
            #duplicate ingredients
            ingredients = dish.ingredients
            dish_cpy.ingredients.delete_all
            ingredients.each do |ingredient|
                dish_cpy.ingredients.append(ingredient.dup)
            end
        end
        
        temporary_menu
    end
    
end
