class PermanentEditController < ApplicationController
    before_action :authenticate_user!
    
    def view_dishes
        day_in_cycle = params[:week].to_i * 7 + params[:day].to_i 
        # day_in_cycle = 11 
        dishes = Menu.get_dishes_by_id(day_in_cycle)
        @week = params[:week].to_i
        @day = params[:day].to_i
        
        @dishes = dishes.to_a
    end
end
