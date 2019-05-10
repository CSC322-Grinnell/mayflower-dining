class PrepController < ApplicationController
  def preppage
     date = Date.today
     if Menu.get_ingredients_by_date(date) != []
       @ingriedent_array = Menu.get_ingredients_by_date(date)
     else 
      @ingriedent_array = [[name: "food", portion_size: "number", done: false, id: 0]]
    end
  end
  
  def checked
      id = params [:id]
      ingredient =get_indredient_by_id(id)
      if ingredient.done == false
        ingredient.done=true
    else
        ingredient.done=false
    end 
  end 
end
