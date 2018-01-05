class Event < ApplicationRecord
  belongs_to :user
  has_many :user_events
  has_many :comments, dependent: :destroy
  scope :ordered_by_date_created, -> {order created_at: :asc}
end
