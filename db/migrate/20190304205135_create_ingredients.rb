class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :portion_size
      t.string :mech_soft
      t.string :pureed
      t.string :diet
      t.integer :hc_prep
      t.integer :hc_prep_leftover
      t.integer :bb_prep
      t.integer :bb_prep_leftover
      t.integer :buckley_prep
      t.integer :buckley_prep_leftover
      t.boolean :done
      t.timestamps
    end
  end
end
