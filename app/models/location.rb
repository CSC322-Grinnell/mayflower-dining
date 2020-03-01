class Location < ApplicationRecord
    validates :name, presence: true,
        length: {minimum: 3, maximum: 30}
    validates :population, presence: true,
        :inclusion => 0..10000
end
