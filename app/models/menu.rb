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
    
    
 
    
    def self.get_dishes_by_id(day_in_cycle)
        Menu.where(day: day_in_cycle)[0].dishes
    end
    
    def self.get_dishes_by_date(date)
        start_date = Date.new(2018, 12, 2)
        
        # using a begin rescue incase date is formatted incorrectly 
        #right now just stops processing
        begin
            end_date = Date.parse(date)
        rescue ArgumentError
            return
        end
        
        day_in_cycle = (end_date - start_date) % 49
        menu = Menu.where(day: day_in_cycle)[0]
        if menu != nil
            menu.dishes.select(:name)
        end
        
        menu
        
    end
    
    def self.get_dishes_by_id(day_in_cycle)
        Menu.where(day: day_in_cycle).dishes
    end
    
    def self.get_dishes_by_date(date)
        start_date = Date.new(2018, 12, 2)
        end_date = Date.parse(date)
        day_in_cycle = (end_date - start_date) % 49
        if !Menu.where(day: day_in_cycle).empty?
            Menu.where(day: day_in_cycle)[0].dishes.select(:name)
        end
    end
        
end