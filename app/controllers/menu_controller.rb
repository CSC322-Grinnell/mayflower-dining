class MenuController < ApplicationController
    def menu 
        date = Time.now.strftime("%d/%m/%Y")
        dishes = Menu.get_dishes_by_date(date)
        @dishes = dishes.to_a
    end
    
    def new_date
        # byebug
        date = params[:date]
        dishes = Menu.get_dishes_by_date(date)
        
        # today = Time.now.strftime("%Y-%m-%d")
        # tommorrow = Time.now + 24*60*60
        # tommorrow = tommorrow.strftime("%Y-%m-%d")
        
        # if  today == date
        #     date = "Today"
        # elsif tommorrow == date
        #     date = "Tomorrow"
        # else
        #     date = Date.parse(date).strftime('%A') + ", " + date.to_s
        # end
        
        # @menu_date = date
        @dishes = dishes.to_a
    end
end
