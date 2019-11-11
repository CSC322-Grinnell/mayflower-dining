#Kuku. This is the new recipe class. It contains the following fields:
# 1) id 2) dishes_id -> id of the dish that this line of recipe refers to
# 3) ingredients_id -> id of the ingredient required for that dish
# 4) portion_size -> size of the portion used in cooking.
# Note, more stuff from current Ingredients db will be moved here as well.


### CRUD:
# Create has to be through appropriate method
# Read by dish or ingredient has to be through appropriate method
# Read of a single recipe can be done directly
# Update for ingredient or dish through appropriate method, portion size can
#   be updated directly
# Destroy can be done directly
### End of CRUD

class Recipe < ApplicationRecord
  validates :dishes_id, presence: true
  validates :ingredients_id, presence: true

  # Creates a recipe given a dish and ingredient
  def self.create_recipe(dish, ingredient, portion_size)
    self.create(dishes_id: dish.id, ingredients_id: ingredient.id, portion_size: portion_size)
  end

  # Gets recipes for a certain dish
  def self.get_recipe_by_dish(dish)
    self.where(dishes_id: dish.id)
  end

  # Gets recipes for a certain ingredient
  def self.get_recipe_by_ingredient(ingredient)
    self.where(ingredients_id: ingredient.id)
  end

  # updates the dish in a recipe, given the recipe and new dish
  def self.update_dish(recipe, dish)
    recipe.dishes_id = dish.id
    recipe.save
    recipe
  end

  # updates the dish in a recipe, given the recipe and new dish
  def self.update_ingredient(recipe, ingredient)
    recipe.ingredients_id = ingredient.id
    recipe.save
    recipe
  end


end
