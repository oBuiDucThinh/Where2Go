class City < ApplicationRecord
  has_many :event_cities, foreign_key: "city_id"
  has_many :events, through: :event_cities
end
