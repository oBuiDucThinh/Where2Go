class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  scope :order_by_date_created,
    ->{select :id, :content, :user_id, :created_at and order date_created: :asc}
end
