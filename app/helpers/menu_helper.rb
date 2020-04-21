require 'date'

module MenuHelper
  # Takes a day in dd/mm/yyyy (or y/m/d) format and converts it to the number of days
  # since 20/01/1999 mod 49, since dishes are stored from days 0-48
  def convert_date_to_day(date)
    #standardize separator
    date = date.gsub('-','/')
    begin
      parse_string = "%d/%m/%Y"
      start_date = Date.strptime("22/12/2011", parse_string)
      curr_date = Date.strptime(date, parse_string)
      return (curr_date - start_date).to_i % 49
    rescue
      parse_string = "%Y/%m/%d"
      start_date = DateTime.strptime("2011/12/22", parse_string)
      curr_date = DateTime.strptime(date, parse_string)
      return (curr_date - start_date).to_i % 49
    end
  end

  #finds the dishes and their recipies for a given meal_type and given day
  # spits out an array in the format [{name: ,recipies: [ingredient: ,portion_size:, comment:, step:, displayed:,]}]
  def find_dishes(date)
    begin
      day = convert_date_to_day(date)
      dishes_menu_arr = DishMenu.get_menu(day)
      dishes = []
      error = nil
      dishes_menu_arr.each do |dish_menu|
        dish = Dish.find(dish_menu.dish_id)
        dishes.push(dish.name)
      end
    rescue => e
        error = "Some #{meal_type} dishes of day #{day} not found. DB is in trouble!!"
    end

    return error, dishes
  end

end
