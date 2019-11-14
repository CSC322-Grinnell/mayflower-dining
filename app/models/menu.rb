
### CRUD:
# Create should be done through the seed, what exists here is just a safety
# Read should be done through appropriate method
# Update for removing or adding dishes should be done through appropriate method
# Destroy should not be done
### End of CRUD


## FOR NOW THE NIL MENU IS MENU NUMBER 100

class Menu < ApplicationRecord
    has_and_belongs_to_many :dishes
    validates :day, presence: true
    validates :type_of_meal, presence: true


    # Validates the input to most functions used here
    def self.validate_menu(day, type)
      raise ArgumentError, 'day in cycle should be 1-49' \
        unless day >= 1 || day <= 49
      raise ArgumentError, 'type of meal is invalid' \
        unless (type.eql? "Breakfast") || (type.eql? "Dinner") || (type.eql? "Supper")
    end

    # Returns an existing menu entry. If needed, it creates one.
    def self.get_menu(day, type)
      self.validate_menu(day, type)
      menu = self.where({day: day, type_of_meal: type})
      if menu.exists?
          menu = menu.first
      else
          menu = self.create!(day: day, type_of_meal: type)
      end

      menu
    end


    # Adds dishes to the appropriate day in the cycle (in Menu database)
    #     and appropriate type
    # If specified day does not exist creates a new day,
    #     else adds new dishes to the Menu record with the given day
    def self.add_dishes_to_cycle(day, type, dishes)
        menu = self.get_menu(day, type)
        dishes.each do |dish|
            DishMenu.create!(dish_id:dish.id, menu_id:menu.id)
        end
        menu
    end

    # Adds a dish to the appropriate day in the cycle (in Menu database)
    #     and appropriate type
    # If specified day does not exist creates a new day,
    #     else adds new dishes to the Menu record with the given day
    def self.add_dish_to_cycle(day, type, dish)
        menu = self.get_menu(day, type)
        DishMenu.create!(dish_id:dish.id, menu_id:menu.id)
        menu
    end

    # Purpose:
    #   Get the array of dishes for a given day and type in the cycle
    #     param verified between 1 - 49
    # Params:
    #   day_in_cycle:a day between 1 - 49, representin a day in the cycle
    #                ie. Week 1, Day 1 = 1; Week 3, Day 5 = ,19
    def self.get_dishes_by_day_type(day, type)
        DishMenu.where(menu_id:self.get_menu(day, type).id)
    end

    # Purpose:
    #   Retrieve and display the array of dishes from database for given date and type
    # Params:
    #   date: a string in the format YYYY-mm-dd
    def self.get_dishes_by_date_type(date, type)
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
        start_date = Date.new(2019, 12, 8)
        day = ((end_date - start_date) % 49 ) + 1
        DishMenu.where(menu_id:self.get_menu(day, type).id)
    end

    # remove a dish from menu with a given day and type
    def self.remove_dish_by_day_type(dish, day, type)
      menu = self.get_menu(day, type)
      DishMenu.where(dish_id:dish.id, menu_id:menu.id).each do |r|
        r.delete
      end
      dish
    end
end
