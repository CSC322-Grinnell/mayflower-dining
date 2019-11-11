class TemporaryMenu < ApplicationRecord
  # has_many: dishes
  # validates :day, presence: true

    # # incomplete documentation
    # # Purpose:
    # #   Adds dishes to temporary menu
    # #   If no instance for that date in temporary menu,
    # #   New instance is created by copying from main cycle
    # # Params:
    # #   date: The date under which dishes will be added
    # #   dishes: an array of dishes
    # def self.add_dishes(date, dishes)
    #
    #     if date.is_a? String
    #         date = Date.parse(date)
    #     end
    #
    #     start_date = Date.new(2019, 12, 8)
    #     day_in_cycle = ((date - start_date) % 49) + 1
    #
    #     if self.where(:date => date).empty?
    #         temporary_menu = self.copy_to_temp_menu(day_in_cycle, date)
    #     else
    #         temporary_menu = self.where(:date => date).first
    #     end
    #
    #     dishes.each do |dish|
    #         temporary_menu.dishes.append(dish)
    #         dish.temporary_menu = temporary_menu
    #     end
    #
    #     temporary_menu
    # end
    #
    # # Purpose:
    # #   Gets an instance of temporary menu with the
    # #   specified date. If instance does not already exist,
    # #   the instance is created by copyng the appropriate instance
    # #   from cycle
    # # To-do:
    # #   Set start date to match cycle by using a global variable.
    # def self.get_menu(date)
    #
    #     if date.is_a? String
    #         date = Date.parse(date)
    #     end
    #
    #     start_date = Date.new(2019, 12, 8)
    #     day_in_cycle = ((date - start_date) % 49) + 1
    #
    #     if self.where(:date => date).empty?
    #         temporary_menu = self.copy_to_temp_menu(day_in_cycle, date)
    #     else
    #         temporary_menu = self.where(:date => date).first
    #     end
    #
    #     temporary_menu
    # end
    #
    # # incomplete
    # # Purpose:
    # #   Makes a copy of the dishes in a given day of the cycle from Menu and
    # #   stores it under the given date in the temporary menu.
    # #   This is so that the data needed for the temporary change is available
    # # Params:
    # #   day_in_cycle:a day between 1 - 49, representin a day in the cycle
    # #                ie. Week 1, Day 1 = 1; Week 3, Day 5 = ,19
    # #   date: a ruby date of which the dishes should  be stored under in the
    # #         temporary menu
    # def self.copy_to_temp_menu(day_in_cycle,date)
    #
    #     if date.is_a? String
    #         date = Date.parse(date)
    #     end
    #
    #     if self.where(:date => date.to_s).empty?
    #         temporary_menu = self.create(date: date)
    #     else
    #         temporary_menu = self.where(:date => date).first
    #     end
    #
    #     menu = Menu.where(:day => day_in_cycle)[0]
    #     dishes =  menu.dishes
    #
    #     dishes.each do |dish|
    #
    #         # duplicate dishes
    #         dish_cpy = dish.dup
    #         temporary_menu.dishes.append(dish_cpy)
    #         dish_cpy.temporary_menu = temporary_menu
    #         dish_cpy.menu = nil
    #         menu.dishes.delete(dish_cpy)
    #
    #         #duplicate ingredients
    #         ingredients = dish.ingredients
    #         dish_cpy.ingredients.delete_all
    #         ingredients.each do |ingredient|
    #             dish_cpy.ingredients.append(ingredient.dup)
    #             dish.ingredients.delete(ingredient.dup)
    #         end
    #     end
    #
    #     temporary_menu
    # end
    #
    # # Purpose:
    # #   Retrieve and display the array of dishes from database for given date
    # #   If there is no instance with the given date in temporary menu
    # #       no instance is created and the dishes in the appropriate day in cycle
    # #       are returned
    # # Params:
    # #   date from the date_picker, can be parsed to Date
    # def self.get_dishes_by_date(date)
    #
    #     if date.is_a? String
    #         date = Date.parse(date)
    #     end
    #
    #     menu = self.where(:date  => date.to_s )[0]
    #     if menu == nil
    #         Menu.get_dishes_by_date(date)
    #     else
    #         menu.dishes
    #     end
    # end
    #
    # # Purpose:
    # #   Remove the records with dates which have past in the temporary menu
    # # Params:
    # #   None
    # # To-do:
    # #   Needs Testing
    # def self.clean_old_records()
    #     self.where("date < ?", 1.days.ago).destroy_all
    # end

end
