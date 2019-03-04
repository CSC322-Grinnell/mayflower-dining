class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.date :day
      t.string :typeOfMeal

      t.timestamps
    end
  end
end
