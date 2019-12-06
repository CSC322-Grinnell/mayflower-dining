class DishMenu < ApplicationRecord
  self.table_name = "dishes_menus"
  belongs_to :dish
  belongs_to :menu

  private 
  def self.clean_up(dishes_menu)
    dishes_menu.each do |dish_menu|
      if dish_menu.temp
        dish_menu.destroy
      elsif !dish_menu.show 
        dish_menu.show = true
        dish_menu.save
      end  
    end 
  end  

  def self.remove_temp_changes()
    now = Time.now.strftime("%d/%m/%Y")

    dishes_menu_breakfast = Menu.get_dishes_by_date_type(now,"Breakfast")
    dishes_menu_dinner = Menu.get_dishes_by_date_type(now,"Dinner")
    dishes_menu_supper = Menu.get_dishes_by_date_type(now,"Supper")

    self.clean_up(dishes_menu_breakfast)
    self.clean_up(dishes_menu_dinner)
    self.clean_up(dishes_menu_supper)
  end 
end
