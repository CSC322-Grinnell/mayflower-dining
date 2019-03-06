class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.integer :day
      t.string :type_of_meal

      t.timestamps
    end
  end
end
