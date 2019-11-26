require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

    test 'add recipe' do
        recipe = Recipe.create_recipe(Dish.find(1), Ingredient.find(1), "ps", "comment")
        assert recipe.valid?
    end

    test 'get recipe by dish' do
        recipes = Recipe.get_recipe_by_dish(Dish.find(1))
        assert_equal(1, recipes.length)
        assert_equal(Recipe.find(1), recipes.first)
    end

    test 'get recipe by ingredient' do
        recipes = Recipe.get_recipe_by_dish(Ingredient.find(1))
        assert_equal(1, recipes.length)
        assert_equal(Recipe.find(1), recipes.first)
    end

    test 'update dish' do
        recipe = Recipe.update_dish(Recipe.find(1), Dish.find(2))
        assert recipe.valid?
        assert_equal(2, Recipe.find(recipe.id).dish_id)
    end

    test 'update ingredient' do
        recipe = Recipe.update_ingredient(Recipe.find(1), Ingredient.find(2))
        assert recipe.valid?
        assert_equal(2, Recipe.find(recipe.id).ingredient_id)
    end
end
