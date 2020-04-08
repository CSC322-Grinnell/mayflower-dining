# This controller is responsible for handling everything that occurs within the menu
# - displaying menu for a given day
# - editing what dishes a menu contains both temporary and permanently
#

require 'date'

class MenuController < ApplicationController
    #the two lines below are fow authentication
    #when in production, use comented out line below to restrict
    #access of anauthorized users to all functionality except
    #menu display
    skip_before_action :verify_authenticity_token
    #before_action :authenticate_user!

    # Takes a day in dd/mm/yyyy format and converts it to the number of days
    # since 01/20/1999 mod 49, since dishes are stored from days 0-48
    def convert_date_to_day(date)
      parse_string = "%m/%d/%Y"
      start_date = Date.strptime("12/22/2011", "%m/%d/%Y")
      curr_date = Date.strptime(date, parse_string)
      return (curr_date - start_date).to_i % 49
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


    # GET
    # displays the menu, accepts optional query parameter date
    # if date is provided, shows menu for that date, otherwise shows
    # menu for today.
    # Renders views/menu/menu.html
    def menu
        date = params[:date] || Time.now.strftime("%d/%m/%Y")
        error, @dinner_dishes = find_dishes(date)
        error, @supper_dishes = find_dishes(date)
        flash[:error] = error
    end


    # GET
    # edit the menu (add/remove dish)
    # url parameters required:
    #   - date
    #   - action: add OR remove
    #   - dish: name of the dish
    #   - type: type of the meal
    #   _ permanent: true or false -> Is the edit permanent or temporary
    # if things go wrong, spits out a flash message
   def edit
     begin
        date = params[:date]
        action = params[:act]
        dish_name = params[:dish]
        type = params[:type]
        permanent = params[:permanent]
        unless date != nil && dish_name != nil && action != nil && type != nil && permanent != nil
            raise "A querry parameter is missing"
        end
        parsed_date = Date.parse(date)
        start_date = Date.new(2019, 12, 8)
        day = ((parsed_date - start_date) % 49 ) + 1
        dish = Dish.get_dish(dish_name)
        if action == "remove"
            Menu.remove_dish_by_day_type(dish,day,type, permanent)
        elsif action == "add"
            Menu.add_dish_to_cycle(day,type,dish, permanent)
        else
            raise "Unknown action"
        end

    rescue => e
        flash[:error] = e
    end

    redirect_to '?date=' + date
   end



end
