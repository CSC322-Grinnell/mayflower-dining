class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      # An  integer from  1 - 49  representing
      # the position in the cycle
      #need to  get the day where the cycle starts (Jan 1st?)
      t.integer :day
      #Entree? Main meal? Salad?
      t.string :type_of_meal

      t.timestamps
    end
  end
end
