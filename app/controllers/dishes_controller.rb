# API to edit the dishes

#TODO: all the views these controls route to are no longer up to date and need fixing
class DishesController < ApplicationController
  #the two lines below are fow authentication
  #when in production, use comented out line below to restrict
  #access of anauthorized users to all functionality except 
  #menu display
  skip_before_action :verify_authenticity_token
  #before_action :authenticate_user!

  # POST
  # makes new dish
  # request.body wants:
  def new
    begin 
#TODO: add dish w/ valid params
      dish = Dish.add_dish()
    rescue => e
      flash[:error] = e
    end
    redirect_to '/menu'
  end


  # POST
  # edit an existing dish
  # request body wants:
  def edit
    begin
      dish = Dish.get_dish( params[:dish_name])
#TODO: edit dish w/ valid params
      dish.save
    rescue => e
      flash[:error] = e
    end
    redirect_to '/menu'

  end

  # GET 
  # returns all dishes in JSON format
  def all
    dishes = Dish.all
    render json: dishes
  end 

  # DELETE 
  # deletes dish with dish.name == query parameter iname
  # request body wants:
  #   - dish name
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
