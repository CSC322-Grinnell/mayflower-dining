# Ingredients controller exposes the APIs to create, edit and destroy
# ingredients in the database.
# All requests result in reload of the main menu page, from where
# we expect to send these requests

class IngredientsController < ApplicationController
  #the two lines below are fow authentication
  #when in production, use comented out line below to restrict
  #access of anauthorized users to all functionality except 
  #menu display
  skip_before_action :verify_authenticity_token
  #before_action :authenticate_user! 

  # POST
  # creates new ingredient in the db
  def new
    name = params[:name]
    # get other values like amount and etc later
    begin
      Ingredient.create(name:name)
    rescue => e
      flash[:error] = e
    end
    redirect_to '/menu'
  end

  # POST
  # request.body wants old_name, new_name
  # edit the ingredient with the old_name, set its name to be new_name 
  def edit
    begin 
      ingredient = Ingredient.get_ingredient(params[:old_name])
      ingredient.name = params[:new_name]
      ingredient.save
    rescue => e
      flash[:error] = e
    end 
    redirect_to '/menu'
  end


  # DELETE
  # delete the ingredient with the query parameter name
  def delete
    begin 
      Ingredient.remove_ingredient(params[:name])
    rescue => e
      flash[:error] = e
    end
    redirect_to '/menu'
  end 

end
