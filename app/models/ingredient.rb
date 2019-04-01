class Ingredient < ApplicationRecord
    belongs_to :dish, optional: true
end
