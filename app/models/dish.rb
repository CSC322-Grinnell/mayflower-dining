class Dish < ApplicationRecord
    has_many :ingredients
    belongs_to :menu, optional: true
    belongs_to :temporary_menu, optional: true
    
    
    def self.add_ingredients_by_id(dish,ingredients)
        for ingredient in ingredients
            dish.ingredients.append(ingredient)
            ingredient.dish = dish 
        end 
    end
        
end
