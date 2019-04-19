class PermanentEditController < ApplicationController
    
    
    def view_dishes
        day_in_cycle = params[:id].to_i 
        # day_in_cycle = 11 
        dishes = Menu.get_dishes_by_id(day_in_cycle)
        @dishes = dishes.to_a
    end
end
