require 'test_helper'

class IngredientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ingredient = ingredients(:one)
  end

  test "should get index" do
    get ingredients_url
    assert_response :success
  end

  test "should get new" do
    get new_ingredient_url
    assert_response :success
  end

  test "should create ingredient" do
    assert_difference('Ingredient.count') do
      post ingredients_url, params: { ingredient: { bb_prep: @ingredient.bb_prep, bb_prep_leftover: @ingredient.bb_prep_leftover, buckley_prep: @ingredient.buckley_prep, buckley_prep_leftover: @ingredient.buckley_prep_leftover, diet: @ingredient.diet, hc_prep: @ingredient.hc_prep, hc_prep_leftover: @ingredient.hc_prep_leftover, mech_soft: @ingredient.mech_soft, name: @ingredient.name, portion_size: @ingredient.portion_size, pureed: @ingredient.pureed } }
    end

    assert_redirected_to ingredient_url(Ingredient.last)
  end

  test "should show ingredient" do
    get ingredient_url(@ingredient)
    assert_response :success
  end

  test "should get edit" do
    get edit_ingredient_url(@ingredient)
    assert_response :success
  end

  test "should update ingredient" do
    patch ingredient_url(@ingredient), params: { ingredient: { bb_prep: @ingredient.bb_prep, bb_prep_leftover: @ingredient.bb_prep_leftover, buckley_prep: @ingredient.buckley_prep, buckley_prep_leftover: @ingredient.buckley_prep_leftover, diet: @ingredient.diet, hc_prep: @ingredient.hc_prep, hc_prep_leftover: @ingredient.hc_prep_leftover, mech_soft: @ingredient.mech_soft, name: @ingredient.name, portion_size: @ingredient.portion_size, pureed: @ingredient.pureed } }
    assert_redirected_to ingredient_url(@ingredient)
  end

  test "should destroy ingredient" do
    assert_difference('Ingredient.count', -1) do
      delete ingredient_url(@ingredient)
    end

    assert_redirected_to ingredients_url
  end
end
