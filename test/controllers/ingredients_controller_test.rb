require 'test_helper'

class IngredientControllerTest < ActionDispatch::IntegrationTest

  test 'should_create_ingredient' do
    assert_difference('Ingredient.count', 1) do
      post ingredients_new_url, params: { name: 'test' }
    end
    assert_redirected_to "/menu"
  end

  test 'should_not_create_ingredient' do
    assert_no_difference('Ingredient.count') do
      post ingredients_edit_url, params: { old_name: 'test', 
                                           new_name: 'test1'}
    end
    assert_redirected_to "/menu"
  end

end
