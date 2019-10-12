class Menu < ApplicationRecord
    #has_many :dishes

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
    #   Get the array of dishes for a given day in the cycle
    #     param verified between 1 - 49
    # Params: 
    #   day_in_cycle:a day between 1 - 49, representin a day in the cycle
    #                ie. Week 1, Day 1 = 1; Week 3, Day 5 = ,19
    def self.get_dishes_by_id(day_in_cycle)
        puts("day_in_cycle")
        Menu.where(day: day_in_cycle).first.dishes
    end
    
    # Purpose:
    #   Retrieve and display the array of dishes from database for given date
    # Params: 
    #   date: a string in the format YYYY-mm-dd
    def self.get_dishes_by_date(date)
        start_date = Date.new(2019, 12, 8)
        
        # using a begin rescue incase date is formatted incorrectly 
        #right now just stops processing
        begin
            if date.is_a? String
                end_date = Date.parse(date)
            else
                end_date = date
            end
        rescue ArgumentError
            return
        end
        
        day_in_cycle = ((end_date - start_date) % 49 ) + 1
        p day_in_cycle
        menu = Menu.where(day: day_in_cycle)[0]

        menu.dishes
    end
    
    # Purpose:
    # output an sorted array that contains multiple arrays that have the 
    # name of the ingredient at index 0 and the amount of the ingredient 
    # at index 1. The ingredients are from the dishes of the input "data"
    def self.get_ingredients_by_date(date)
        # dishes_array is a 3d array 
        new_dish_array=[]
        dishs_array =TemporaryMenu.get_dishes_by_date(date);
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
                new_dish_array.push([ingredient.name,ingredient.portion_size,ingredient.done, ingredient.id])
            end 
            #sort the array
            sorted_array=new_dish_array.sort{|a,b| a[0]<=>b[0]}
        else
            sorted_array = []
        end 

        return sorted_array
    end 


    def self.get_indredient_by_id(id)
        Ingredient.find(id)
    end 

end