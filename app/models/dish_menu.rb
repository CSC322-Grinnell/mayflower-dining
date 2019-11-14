class DishMenu < ApplicationRecord
  self.table_name = "dishes_menus"
  belongs_to :dish
  belongs_to :menu
end
