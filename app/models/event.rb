class Event < ApplicationRecord
  after_create :close
  after_find do
    self.close
  end

  belongs_to :user, foreign_key: :user_id
  has_many :user_events
  has_many :users, through: :user_events
  has_many :comments, dependent: :destroy
  scope :order_by_title, ->{order title: :asc}
  scope :ordered_by_date_created, -> {order created_at: :asc}
  has_many :users, through: :comments
  has_many :event_categories, foreign_key: :event_id, inverse_of: :event
  has_many :categories, through: :event_categories
  has_many :event_cities, foreign_key: :event_id, inverse_of: :event
  has_many :cities, through: :event_cities
  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :cities
  mount_uploader :picture, PictureUploader
  scope :load_event_info, ->{select :id, :title, :content, :date_start, :date_end, :is_open, :picture, :user_id}
  scope :ordered_by_date_created, -> {order created_at: :desc}
  scope :load_event_open, ->{where "date_start < ? AND is_open = ? ", Date.today, true}
  scope :load_event_close, ->{where is_open: false}
  scope :load_event_coming, ->{where "date_start > ?", Date.today}

  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :date_start, presence: true
  validates :date_end, presence: true
  validates :category_ids, presence: true
  validates :city_ids, presence: true
  validates :picture, presence: true

  def close
    if self.date_end < Date.today
      update_attributes is_open: false
    end
  end

end
