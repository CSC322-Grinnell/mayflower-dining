require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
    
    test 'add ingredient' do
        ingredient = Ingredient.new(name: 'Potatoes')
        assert ingredient.valid?
    end
  
    test 'delete ingredient' do
        ingredient = Ingredient.new(name: 'Potatoes')
        assert ingredient.valid?
    end
 

end