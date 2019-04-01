class TemporaryMenuRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :temporary_menus, :dish_id, :integer
    add_index  :temporary_menus, :dish_id
  end
end
