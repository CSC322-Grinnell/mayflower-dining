### CRUD:
# Create has to be done through appropriate (0 validations for now)
# Read can be done directly, but is safer if done through here
# Update by the appropriate method.
# Destroy has to be done through appropriate method
### End of CRUD

class Dish < ApplicationRecord
    has_and_belongs_to_many :menus
    has_many :recipes
    validates :name, presence: true
    # belongs_to :temporary_menu, optional: true


    # Creates a dish
    # First input is name of dish
    # Second input is a list of recipes, each of which is a list in
    #   the following format:
    #   [ingredient_name, portion_size, comment]
    def self.add_dish(name, description, recipes)
      # create dish
      dish = self.create!(name:name, description:description)
      # create the recipes for this dish
      recipes.each do |recipe|
        Recipe.create_recipe(dish, Ingredient.get_ingredient(recipe[0]), recipe[1], recipe[2])
      end

      dish
    end

    # gets a recipe from its name
    # validates input
    def self.get_dish(name)
      dish = self.where(name:name)
      raise ArgumentError, "Dish doesn't exist." unless !dish.empty?
      dish.first
    end


    # updates a dishes name
    # validates input
    def self.update_name(name, new_name)
      dish = self.get_dish(name)
      dish.name = new_name
      dish.save
      dish
    end
    # destroy a dish based on name
    # also destroys its recipes
    def self.remove_dish(name)
      dish = self.get_dish(name)
      raise ArgumentError, "Dependent menu exist. Remove from menu before removing from dishes." \
        unless not DishMenu.exists?(dish_id:dish.id)

      # delete acompanying recipes
      recipes = Recipe.get_recipe_by_dish(dish)
      recipes.each do |recipe|
        recipe.destroy
      end

      # destroy dish
      dish.destroy

      dish
    end
end
