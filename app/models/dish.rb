class Dish < ApplicationRecord
    has_many :ingredients
    belongs_to :menu, optional: true
    belongs_to :temporary_menu, optional: true
end
