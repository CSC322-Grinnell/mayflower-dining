class IngredientsController < ApplicationController
  skip_before_action :verify_authenticity_token
  #before_action :authenticate_user!

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



  def delete
    begin 
      Ingredient.remove_ingredient(params[:name])
    rescue => e
      flash[:error] = e
    end
    redirect_to '/menu'
  end 

end
