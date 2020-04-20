### CRUD:
# Create has to be done through appropriate (0 validations for now)
# Read can be done directly, but is safer if done through here
# Update by the appropriate method.
# Destroy has to be done through appropriate method
### End of CRUD

class Dish < ApplicationRecord
    validates :name, presence: true
    validates :star, :inclusion => 0..3
    validates :mesh_soft, :inclusion => 0..2

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

      # destroy dish
      dish.destroy

      dish
    end
end
