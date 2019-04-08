class Dish < ApplicationRecord
    has_many :ingredients
    belongs_to :menu, optional: true
    belongs_to :temporary_menu, optional: true
    
    
    def self.add_ingredients(dish,ingredients)
        if ingredients !=nil
            for ingredient in ingredients
                dish.ingredients.append(ingredient)
                ingredient.dish = dish 
            end 
        end 
    end
    
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
