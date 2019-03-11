class Dish < ApplicationRecord
    has_many :ingredients
    belongs_to :menu, optional: true
    belongs_to :temporary_menu, optional: true
    
    
    def self.add_ingredients(ingredients)
        for ingredient in ingredients
            self.ingredients.append(ingredient)
        end 
    end
end
