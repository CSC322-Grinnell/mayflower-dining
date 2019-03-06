class Dish < ApplicationRecord
    has_many :ingredients
    belongs_to :menus
    belongs_to :temporary_menus
end
