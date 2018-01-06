class Event < ApplicationRecord
  belongs_to :user, optional: true
  has_many :user_events
  has_many :users, through: :user_events
  has_many :comments, dependent: :destroy
  scope :ordered_by_date_created, -> {order created_at: :asc}
  has_many :users, through: :comments
  has_many :event_categories, foreign_key: :event_id, inverse_of: :event
  has_many :categories, through: :event_categories
  has_many :event_cities, foreign_key: :event_id, inverse_of: :event
  has_many :cities, through: :event_cities
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :cities

  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :date_start, presence: true
  validates :date_end, presence: true
  validates :category_ids, presence: true
  validates :city_ids, presence: true
end
