class CreateDishesMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.belongs_to :dish
      t.integer :day # 0-48
      t.string :hc_prep
      t.string :hc_leftover
      t.string :bb_prep
      t.string :bb_leftover
      t.string :buckley_prep
      t.string :buckley_leftover
    end
  end
end
