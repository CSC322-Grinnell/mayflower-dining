class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :dishes, :ingredient_id, :integer
    add_index  :dishes, :ingredient_id
    add_column :menus, :dish_id, :integer
    add_index  :menus, :dish_id
    
    change_column :ingredients, :hcPrep, :integer
    change_column :ingredients, :hcPrepLeftover, :integer
    change_column :ingredients, :bbPrep, :integer
    change_column :ingredients, :bbPrepLeftover, :integer
    change_column :ingredients, :buckleyPrep, :integer
    change_column :ingredients, :buckleyPrepLeftover, :integer
  end
end
