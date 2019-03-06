class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :dishes, :ingredient_id, :integer
    add_index  :dishes, :ingredient_id
    add_column :menus, :dish_id, :integer
    add_index  :menus, :dish_id
  end
end