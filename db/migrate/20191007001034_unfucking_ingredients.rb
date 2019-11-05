class UnfuckingIngredients < ActiveRecord::Migration[5.2]
  def change

      create_table :recipes do |t|
        t.references :dishes 
        t.references :ingredients
        t.string :portion_size
      end 

      remove_column :ingredients, :portion_size
      remove_column :ingredients, :dish_id
      remove_column :dishes, :ingredient_id
      #remove_column :dishes, :menu_id
      remove_column :dishes, :temporary_menu_id
      remove_column :menus, :dish_id
      remove_column :ingredients, :done
      
      add_column :menus, :dish_ids, :integer, array: true, default: []
     
  end
end
