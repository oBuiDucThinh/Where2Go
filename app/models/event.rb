class Event < ApplicationRecord
  belongs_to :user
  has_many :user_events
  has_many :comments, dependent: :destroy
end
