class Category < ApplicationRecord
  has_many :events, through: :event_categories
  has_many :event_categories, foreign_key: :category_id
  has_many :users, through: :user_categories
  has_many :user_categories, foreign_key: :category_id
end
