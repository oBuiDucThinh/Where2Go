class Category < ApplicationRecord
  has_many :event_categories, foreign_key: :category_id
  has_many :user_categories, foreign_key: :category_id
end
