class CreateTemporaryMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :temporary_menus do |t|
      #date which overides cycle
      t.date :date
      #Entree? Main meal? Salad?
      t.string :type_of_meal
      t.timestamps
    end
  end
end
