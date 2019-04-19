class Dish < ApplicationRecord
    has_many :ingredients
    belongs_to :menu, optional: true
    belongs_to :temporary_menu, optional: true
    
    # Purpose:
    #   used for temporary_add with duplicate ingredients
    #   add ingredients to corresponding dish into the database
    # Params:
    #   dish: the dish added to the database
    #   ingredients: an array of ingredients
    def self.add_ingredients(dish,ingredients)
        if ingredients !=nil
            for ingredient in ingredients
                dish.ingredients.append(ingredient)
                ingredient.dish = dish 
            end 
        end 
    end
    
    # Purpose:
    #   used for add_item
    #   add ingredients to corresponding dish into the database
    # Params:
    #   dish: the dish added to the database
    #   ingredient_dictionaries: an array of ingredients with amount descriptions
    def self.add_ingredients_with_dictionary(dish,ingredient_dictionaries)
        if ingredient_dictionaries != nil
            ingredient_dictionaries.each do |index,item|
                ingredient = Ingredient.create(name: item[:name], portion_size: item[:amount] )
                dish.ingredients.append(ingredient)
                ingredient.dish = dish 
            end 
        end 
    end
end
