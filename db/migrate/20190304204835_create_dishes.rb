class CreateDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|
      t.string :name 
      t.integer :star # 4 options
      t.integer :mesh_soft # 3 options
      t.string :puree
      t.string :portion_size
      t.string :diet
      t.timestamps
    end
  end
end
