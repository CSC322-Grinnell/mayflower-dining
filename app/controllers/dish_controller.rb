class DishController < ApplicationController
    before_action :authenticate_user!
    
    def add_to_cycle
        # create dish
        dish = Dish.new(name: params[:dish_name])
        # add ingredients
        ingredients = params[:ingredient]
        Dish.add_ingredients_with_dictionary(dish,ingredients)
        # add to cycle
        if dish.valid?
            dish.save()
            dish_date = (params[:dish_date_week].to_i * 7 + params[:dish_date_day].to_i);
            Menu.add_dishes_to_cycle(dish_date, [dish])
        end
        
        # redirect to main page or show complete page
        redirect_to root_path
    end
    
    def add_to_temp
        # create dish
        dish = Dish.new(name: params[:dish_name])
        # add ingredients
        ingredients = params[:ingredient]
        Dish.add_ingredients_with_dictionary(dish,ingredients)
        # add to cycle
        if dish.valid?
            dish.save()
            dish_date = Date.parse(params[:date])
            TemporaryMenu.add_dishes(dish_date, [dish])
        end
        
        # redirect to main page or show complete page
        redirect_to root_path
    end
end
