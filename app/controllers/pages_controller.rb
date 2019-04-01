class PagesController < ApplicationController
  def home
  end
  
  def menu
      date = Time.now.strftime("%d/%m/%Y")
      dishes = Menu.get_dishes_by_date(date)
      @dishes = dishes.to_a
  end
end
