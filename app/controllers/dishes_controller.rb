# API to edit the dishes


class DishesController < ApplicationController
  #the two lines below are fow authentication
  #when in production, use comented out line below to restrict
  #access of anauthorized users to all functionality except
  #menu display
  before_action :authenticate_admin

  # POST
  # makes new dish
  # request.body wants:
  #   - dish_name
  #   - recipies (arr in the form of [ingredient_name, portion_size, comment])
  #   - description
  def new
    dish_name = params[:dish_name]
    recipies = params[:recipies]
    description = params[:description]
    begin
      dish = Dish.add_dish(dish_name, description, recipies.values)
    rescue => e
      flash[:error] = e
    end
    redirect_to '/menu'
  end


  # POST
  # edit an existing dish
  # request body wants:
  #   - dish_name
  #   - recipies as from above
  #   - new_name
  #   - description
  # and it substitutes what's in the db for given body fields
  def edit
    begin
      dish = Dish.get_dish( params[:dish_name])
      new_recipies = params[:recipies].values
      new_name = params[:name]
      new_desc = params[:description]
      recipies_to_remove = Recipe.get_recipe_by_dish(dish)
      if new_name != nil
        dish.name = new_name
      end
      if new_desc != nil
        dish.description = new_desc
      end
      if recipies_to_remove != nil
        recipies_to_remove.each do |recipe|
          recipe.destroy
        end
      end
      new_recipies.each do |recipe|
        Recipe.create_recipe(dish, Ingredient.get_ingredient(recipe[0]), recipe[1], recipe[2])
      end
      dish.save
    rescue => e
      flash[:error] = e
    end
    redirect_to '/menu'

  end

  # GET
  # returns all dishes
  def all
    dishes = Dish.all
    render json: dishes
  end

  # DELETE
  # deletes dish with dish.name == query parameter name
  def delete
      begin
        dish = Dish.get_dish(params[:name])
        Dish.remove_dish(dish.name)
      rescue => e
        flash[:error] = e
    end
    redirect_to '/menu'
  end

end
