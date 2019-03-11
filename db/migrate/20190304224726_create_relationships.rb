class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :dishes, :ingredient_id, :integer
    add_index  :dishes, :ingredient_id
    add_column :dishes, :menu_id, :integer
    add_index  :dishes, :menu_id
    add_column :menus, :dish_id, :integer
    add_index  :menus, :dish_id
    add_column :ingredients, :dish_id, :integer
    add_index  :ingredients, :dish_id
  end
end