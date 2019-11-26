class DropTempMenu < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :comment, :string
    add_column :recipes, :step, :integer
    
    add_column :dishes, :description, :string
    add_column :dishes, :dish_type, :string
    
    drop_table :temporary_menus

  end
end
