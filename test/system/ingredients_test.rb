require "application_system_test_case"

class IngredientsTest < ApplicationSystemTestCase
  setup do
    @ingredient = ingredients(:one)
  end

  test "visiting the index" do
    visit ingredients_url
    assert_selector "h1", text: "Ingredients"
  end

  test "creating a Ingredient" do
    visit ingredients_url
    click_on "New Ingredient"

    fill_in "Bb Prep", with: @ingredient.bb_prep
    fill_in "Bb Prep Leftover", with: @ingredient.bb_prep_leftover
    fill_in "Buckley Prep", with: @ingredient.buckley_prep
    fill_in "Buckley Prep Leftover", with: @ingredient.buckley_prep_leftover
    fill_in "Diet", with: @ingredient.diet
    fill_in "Hc Prep", with: @ingredient.hc_prep
    fill_in "Hc Prep Leftover", with: @ingredient.hc_prep_leftover
    fill_in "Mech Soft", with: @ingredient.mech_soft
    fill_in "Name", with: @ingredient.name
    fill_in "Portion Size", with: @ingredient.portion_size
    fill_in "Pureed", with: @ingredient.pureed
    click_on "Create Ingredient"

    assert_text "Ingredient was successfully created"
    click_on "Back"
  end

  test "updating a Ingredient" do
    visit ingredients_url
    click_on "Edit", match: :first

    fill_in "Bb Prep", with: @ingredient.bb_prep
    fill_in "Bb Prep Leftover", with: @ingredient.bb_prep_leftover
    fill_in "Buckley Prep", with: @ingredient.buckley_prep
    fill_in "Buckley Prep Leftover", with: @ingredient.buckley_prep_leftover
    fill_in "Diet", with: @ingredient.diet
    fill_in "Hc Prep", with: @ingredient.hc_prep
    fill_in "Hc Prep Leftover", with: @ingredient.hc_prep_leftover
    fill_in "Mech Soft", with: @ingredient.mech_soft
    fill_in "Name", with: @ingredient.name
    fill_in "Portion Size", with: @ingredient.portion_size
    fill_in "Pureed", with: @ingredient.pureed
    click_on "Update Ingredient"

    assert_text "Ingredient was successfully updated"
    click_on "Back"
  end

  test "destroying a Ingredient" do
    visit ingredients_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ingredient was successfully destroyed"
  end
end
