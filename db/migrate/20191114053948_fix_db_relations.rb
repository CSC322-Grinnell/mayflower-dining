class FixDbRelations < ActiveRecord::Migration[5.2]
  def change

    add_index :menus, [:day, :type_of_meal], unique: true,  name: "by_day_type_of_meal"

    remove_column :menus, :dish_ids, :integer, array: true, default: []
    remove_column :recipes, :dishes_id, :bigint, index: true
    remove_column :recipes, :ingredients_id, :bigint, index: true

    add_belongs_to :recipes, :dish
    add_belongs_to :recipes, :ingredient

    # TODO: Add these later
    # add_column :recipes, :comment, :string
    # add_column :recipes, :step, :integer

    create_table :dishes_menus do |t|
      t.belongs_to :dish
      t.belongs_to :menu
      t.boolean :temp, default: false
      t.boolean :show, default: true
    end



  end
end
