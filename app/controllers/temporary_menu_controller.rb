class TemporaryMenuController < ApplicationController
    def menu
        # display the menu for the current day
        date = Time.now.strftime("%d/%m/%Y")
        dishes = TemporaryMenu.get_menu(date).dishes
        @dishes = dishes.to_a
    end
    
    def new_date
        # byebug
        # One of our hardworking team member spent one week on this bug 
        # and we think it is worth commemorating
        date = params[:date]
        dishes = TemporaryMenu.get_menu(date).dishes
        
        # today = Time.now.strftime("%Y-%m-%d")
        # checks the target date and display corresponding menu
        @dishes = dishes.to_a
    end
    
    def edit 
        
    end
    
    def delete
    end
    
end
