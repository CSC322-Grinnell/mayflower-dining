class PrepPageController < ApplicationController
  def prep_page
    date = Time.now.strftime("%d/%m/%Y")
    if Menu.get_ingredients_by_date(date) != nil
      @ingriedent_array= Menu.get_ingredients_by_date(date)
    end
  end
end