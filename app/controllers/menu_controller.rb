class MenuController < ApplicationController
    def menu
        # display the menu for the current day
        date = Time.now.strftime("%d/%m/%Y")
        dishes = Menu.get_dishes_by_date(date)
        @dishes = dishes.to_a
    end
    
    def new_date
        # byebug
        # One of our hardworking team member spent one week on this bug 
        # and we think it is worth commemorating
        date = params[:date]
        dishes = Menu.get_dishes_by_date(date)

        @dishes = dishes.to_a
    end
    
end
