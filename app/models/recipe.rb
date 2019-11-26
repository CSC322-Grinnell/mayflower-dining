### CRUD:
# Create has to be through appropriate method
# Read by dish or ingredient has to be through appropriate method
# Read of a single recipe can be done directly
# Update for ingredient or dish through appropriate method, portion size can
#   be updated directly
# Destroy can be done directly
### End of CRUD

class Recipe < ApplicationRecord
  belongs_to :dish, optional: true
  belongs_to :ingredient, optional: true


  # Creates a recipe given a dish and ingredient
  def self.create_recipe(dish, ingredient, portion_size, comment)
    self.create!(dish: dish, ingredient: ingredient, portion_size: portion_size, comment:comment )
  end

  # Gets recipes for a certain dish
  def self.get_recipe_by_dish(dish)
    self.where(dish: dish)
  end

  # Gets recipes for a certain ingredient
  def self.get_recipe_by_ingredient(ingredient)
    self.where(ingredient: ingredient)
  end

  # updates the dish in a recipe, given the recipe and new dish
  def self.update_dish(recipe, dish)
    recipe.dish = dish
    recipe.save
    recipe
  end

  # updates the dish in a recipe, given the recipe and new dish
  def self.update_ingredient(recipe, ingredient)
    recipe.ingredient = ingredient
    recipe.save
    recipe
  end


end
