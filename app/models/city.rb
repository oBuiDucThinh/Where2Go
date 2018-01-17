class City < ApplicationRecord
  has_many :event_cities, foreign_key: "city_id"
  has_many :events, through: :event_cities

  def self.options_for_select
    order("LOWER(city_name)").map {|e| [e.city_name, e.id]}
  end
end
