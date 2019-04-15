require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
    
    test 'add ingredient' do
        ingredient = Ingredient.new
        assert ingredient.valid?
    end
  
    test 'delete ingredient' do
        ingredient = Ingredient.create(name: 'Potatoes')
         len = Ingredient.all.length 
        ingredient.destroy
        assert_equal((len - 1),Ingredient.all.length)
    end
 

end