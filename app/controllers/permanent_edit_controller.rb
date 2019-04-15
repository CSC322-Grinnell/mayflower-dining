class PermanentEditController < ApplicationController
    def view_dishes
        
        day_in_cycle = params[:dish_date_week].to_i * 7 + params[:dish_date_day].to_i
        dishes = Menu.get_dishes_by_id(day_in_cycle)
        @dishes = dishes.to_a
    end
end
