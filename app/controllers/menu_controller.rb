class MenuController < ApplicationController
    def menu 
        date = Time.now.strftime("%d/%m/%Y")
        dishes = Menu.get_dishes_by_date(date)
        @dishes = dishes.to_a
    end
    
    def new_date
        date = params[:date]
        dishes = Menu.get_dishes_by_date(date)
        
        today = Time.now.strftime("%Y-%m-%d")
        if  today == date
            date = "today"
        end
        
        @menu_date = date
        @dishes = dishes.to_a
    end
end
