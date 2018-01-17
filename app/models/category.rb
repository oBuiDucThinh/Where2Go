class Category < ApplicationRecord
  has_many :events, through: :event_categories
  has_many :event_categories, foreign_key: :category_id
  has_many :users, through: :user_categories
  has_many :user_categories, foreign_key: :category_id

  scope :user_edit_subscribe, ->{select :id, :name}

  def self.options_for_select
    order("LOWER(name)").map {|e| [e.name, e.id]}
  end
end
