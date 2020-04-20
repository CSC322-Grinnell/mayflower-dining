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


    # GET
    # displays the menu, accepts optional query parameter date
    # if date is provided, shows menu for that date, otherwise shows
    # menu for today.
    # Renders views/menu/menu.html
    def menu
        date = params[:date] || Time.now.strftime("%d/%m/%Y")
        error, @daily_dishes = find_dishes(date)
        flash[:error] = error
    end


    # GET
    # edit the menu (add/remove an EXISTING dish)
    # url parameters required:
    #   - date: dd-mm-YYYY format
    #   - action: add OR remove
    #   - dish: name of the dish
    #   - type: aka 0-3 stars--whether dish is on any special default menus
    #   - permanent: true or false -> Is the edit permanent or temporary
    # if things go wrong, spits out a flash message
    def edit
      begin
         date = params[:date]
         action = params[:act]
         dish_name = params[:dish]
         #TODO: these are currently unused fields; remove? 
         type = params[:type]
         permanent = params[:permanent]
         unless date != nil && dish_name != nil && action != nil && type != nil && permanent != nil
             raise "A querry parameter is missing"
         end
         day = convert_date_to_day(date.gsub('/','-'))
         dish = Dish.get_dish(dish_name.capitalize)
         puts "dish: #{dish}, dish anem: #{dish_name}"
         if action == "remove"
             DishMenu.remove_dish_from_cycle(day, dish)
         elsif action == "add"
             DishMenu.add_dish_to_cycle(day,dish)
         else
             raise "Unknown action"
         end

     rescue => e
         flash[:error] = e
     end

     redirect_to '/menu/' + date.gsub('/','-')
    end

    private
    # Local helper methods

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
