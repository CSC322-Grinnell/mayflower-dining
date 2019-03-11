require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
    
    test 'add ingredient' do
        ingredient = Ingredient.new
        assert ingredient.valid?
    end
  
    test 'delete ingredient' do
        ingredient = Ingredient.create(name: 'Potatoes')
        # loads 2 fixtures as well
        assert_equal(3,Ingredient.all.length)
        ingredient.destroy
        assert_equal(2,Ingredient.all.length)
    end
 

end