### CRUD:
# Create has to be directly for now (0 validations for now)
# Read should happen through appropriate method
# Update can be done directly
# Destroy has to be done through appropriate method
### End of CRUD


class Ingredient < ApplicationRecord
  has_many :recipes
  validates :name, presence: true

  # gets an ingredient from its name
  # validates input
  def self.get_ingredient(name)
      ingr = self.where(name:name)
      raise ArgumentError, "Ingredient doesn't exist." unless !ingr.empty?
      ingr.first
  end

  # destroy an ingredient based on name
  # can only happen if no recipe uses this ingredient
  def self.remove_ingredient(name)
    ingr = self.get_ingredient(name)
    raise ArgumentError, "Dependent recipes exist. Remove those before removing ingredient." \
      unless Recipe.get_recipe_by_ingredient(ingr).empty?

    ingr.destroy
  end

end
