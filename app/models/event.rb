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

  filterrific(
    default_filter_params: {sorted_by: "created_at_asc"},
    available_filters: [
      :sorted_by,
      :with_category_id,
      :with_city_id,
      :with_date_start_gte
    ]
  )

  scope :sorted_by, lambda {|sort_option|
    direction = (sort_option =~ /desc$/) ? "desc" : "asc"
    case sort_option.to_s
    when /^created_at_/
      order "events.created_at #{ direction }"
    when /^date_start_/
      order "events.date_start #{ direction }"
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_category_id, lambda {|category_ids|
    event_categories = EventCategory.arel_table
    events = Event.arel_table
    where(
      EventCategory \
        .where(event_categories[:event_id].eq(events[:id])) \
        .where(event_categories[:category_id].in([*category_ids].map(&:to_i))) \
        .exists
    )
  }

  scope :with_city_id, lambda {|city_ids|
    event_cities = EventCity.arel_table
    events = Event.arel_table
    where(
      EventCity \
        .where(event_cities[:event_id].eq(events[:id])) \
        .where(event_cities[:city_id].in([*city_ids].map(&:to_i))) \
        .exists
    )
  }

  scope :with_date_start_gte, lambda {|reference_time|
    where "events.date_start >= ?", reference_time
  }

  scope :with_date_end_lt, lambda {|reference_time|
    where "events.date_start < ?", reference_time
  }

  def self.options_for_sorted_by
    [
      ["Created date (newest first)", "created_at_desc"],
      ["Created date (oldest first)", "created_at_asc"],
      ["Start date (newest first)", "date_start_desc"],
      ["Start date (oldest first)", "date_start_asc"],
    ]
  end
end
