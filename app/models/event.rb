class Event < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  has_many :like_events
  has_many :users, through: :like_events
  has_many :join_events
  has_many :users, through: :join_events
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments
  has_many :event_categories, foreign_key: :event_id, inverse_of: :event
  has_many :categories, through: :event_categories
  has_many :event_cities, foreign_key: :event_id, inverse_of: :event
  has_many :cities, through: :event_cities
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :cities
  mount_uploader :picture, PictureUploader
  scope :ordered_by_date_created, -> {order created_at: :asc}

  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :date_start, presence: true
  validates :date_end, presence: true
  validates :category_ids, presence: true
  validates :city_ids, presence: true
  validates :picture, presence: true
end
