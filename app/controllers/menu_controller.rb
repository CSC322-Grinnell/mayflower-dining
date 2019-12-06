# This controller is responsible for handling everything that occurs within the menu
# - displaying menu for a given day
# - editing what dishes a menu contains both temporary and permanently 
# 


class MenuController < ApplicationController
    #the two lines below are fow authentication
    #when in production, use comented out line below to restrict
    #access of anauthorized users to all functionality except 
    #menu display
    skip_before_action :verify_authenticity_token
    #before_action :authenticate_user!

    #finds the dishes and their recipies for a given meal_type and given day
    # spits out an array in the format [{name: ,recipies: [ingredient: ,portion_size:, comment:, step:, displayed:,]}]
    def find_dishes(meal_type,day)
        dishes_menu_arr = Menu.get_dishes_by_date_type(day,meal_type)
        dishes = []
        error = nil
        dishes_menu_arr.each do |dish_menu|
            begin 
                if dish_menu.show || current_user
                    dish = Dish.find(dish_menu.dish_id)
                        dish_recipies = Recipe.get_recipe_by_dish(dish)
                        recipies = []
                        dish_recipies.each do |recipe|
                            recipies.push(OpenStruct.new({
                                "ingredient" => Ingredient.find(recipe.ingredient_id).name,
                                "portion_size" => current_user ? recipe.portion_size : nil,
                                "comment" => current_user ? recipe.comment : nil, 
                                "step" => current_user ? recipe.step : nil,
                                "displayed" => current_user ? dish_menu.show : nil
                                }))
                        end 
                        dishes.push(OpenStruct.new({"name" => dish.name, "recipies" => recipies}) )
                    end
            rescue => e
                error = "Some #{meal_type} dishes of day #{day} not found. DB is in trouble!!" 
            end
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
        error, @dinner_dishes = find_dishes("Dinner",date)
        error, @supper_dishes = find_dishes("Supper",date)
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

    redirect_to '/menu'
   end 
    


end
