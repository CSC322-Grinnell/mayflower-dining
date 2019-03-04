class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :portionSize?
      t.string :mechSoft
      t.string :pureed
      t.string :diet
      t.string :hcPrep
      t.string :hcPrepLeftover
      t.string :bbPrep
      t.string :bbPrepLeftover
      t.string :buckleyPrep
      t.string :buckleyPrepLeftover

      t.timestamps
    end
  end
end
