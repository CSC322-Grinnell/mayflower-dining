class DishController < ApplicationController
    def add_to_cycle
        # create dish
        dish = Dish.new(name: params[:dish_name])
        # add ingredients
        ingredients = params[:ingredient]
        Dish.add_ingredients_with_dictionary(dish,ingredients)
        # add to cycle
        if dish.valid?
            dish.save()
            Menu.add_dishes_to_cycle(params[:dish_date], [dish])
        end
        
    end
end
