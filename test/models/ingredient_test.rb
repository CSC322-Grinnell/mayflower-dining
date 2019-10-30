require 'test_helper'

class IngredientTest < ActiveSupport::TestCase

    test 'add ingredient' do
        ingredient = Ingredient.create(name:"something")
        assert ingredient.valid?
    end

    test 'get ingredients fail' do
      assert_raise ArgumentError do
        Ingredient.get_ingredient("I don't exist :)")
      end
    end

    test 'get ingredients succeed' do
      ingredient = Ingredient.get_ingredient("one")
      assert ingredient.valid?
      assert_equal(Ingredient.where(name:"one").first, ingredient)
    end


    test 'remove ingredient fail' do
      ingr = Ingredient.find(1)
      assert_raise ArgumentError do
        Ingredient.remove_ingredient(ingr.name)
      end
    end

    test 'remove ingredient succeed' do
      ingr = Ingredient.find(3)
      assert_equal(ingr, Ingredient.remove_ingredient(ingr.name))
      assert_not Ingredient.exists?(ingr.id)
    end

end
