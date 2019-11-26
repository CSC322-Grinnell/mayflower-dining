class MenuController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    #finds the dishes and their recipies for a given meal_type and given day
    # spits out an array in the format [{name: ,recipies: [ingredient: ,portion_size:, comment:, step:, displayed:,]}]
    def find_dishes(meal_type,day)
        dishes_menu_arr = Menu.get_dishes_by_day_type(day,meal_type)
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

    def menu
        # 1'st day hardcoded for now that the db and seed doesn't have all the data. Later, well use date
        date = params[:date] || Time.now.strftime("%d/%m/%Y")
        error, @lunch_dishes = find_dishes("Dinner",1)
        flash[:error] = error
    end 


    # edit the menu (add/remove dish)
    # week, day are url params (see routes)
    # request.body requires: 
    #   - change_action: add OR remove
    #   - dish_name: name of the dish
    #   - type: type of the meal
    # if things go wrong, spits out a flash message
   def edit
    week = params[:week].to_i
    day = params[:day].to_i
    error = nil
    if week > 6 || week < 0 || day > 6 || day < 0
        error = 'Impossible week/day url parameters'
    else 
        begin
            action = params[:change_action]
            dish_name = params[:dish_name]
            type = params[:type]
            dish = Dish.get_dish(dish_name)
            day = 7*(week) + day + 1
            if action == nil || dish_name == nil
                error = "Action or dish name is missing in request body"
            end

            if action == "remove" 
                Menu.remove_dish_by_day_type(dish,day,type)
            elsif action == "add"
                Menu.add_dish_to_cycle(day,type,dish)
            else 
                error = "Unknown action" 
            end
             
        rescue => e
            error = e
        end
    end
    flash[:error] = error
    redirect_to '/menu'
   end 
    


end
