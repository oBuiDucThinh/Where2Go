class Event < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  belongs_to :user
  has_many :like_events, dependent: :destroy
  has_many :liked_by_users, through: :like_events, class_name: :User
  has_many :join_events, dependent: :destroy
  has_many :joined_by_users, through: :join_events, class_name: :User
  has_many :comments, dependent: :destroy
  has_many :commented_by_users, through: :comments, class_name: :User
  has_many :event_categories, foreign_key: :event_id, inverse_of: :event, dependent: :destroy
  has_many :categories, through: :event_categories
  has_many :event_cities, foreign_key: :event_id, inverse_of: :event, dependent: :destroy
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
  validates :address, presence: true

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
      order("events.created_at #{ direction }")
    when /^date_start_/
      order("events.date_start #{ direction }")
    when /^most_like_/
      select("events.*, count(like_events.event_id) as likes_count")
        .joins(:like_events).group(:event_id).order("likes_count #{ direction }")
    when /^most_join_/
      select("events.*, count(join_events.event_id) as joins_count")
        .joins(:join_events).group(:event_id).order("joins_count #{ direction }")
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
    where("events.date_start >= ?", reference_time)
  }

  scope :with_date_end_lt, lambda {|reference_time|
    where("events.date_start < ?", reference_time)
  }

  def self.options_for_sorted_by
    [
      ["Created date (newest first)", "created_at_desc"],
      ["Created date (oldest first)", "created_at_asc"],
      ["Start date (newest first)", "date_start_desc"],
      ["Start date (oldest first)", "date_start_asc"],
      ["Most liked", "most_like_desc"],
      ["Less liked", "most_like_asc"],
      ["Most joined", "most_join_desc"],
      ["Less joined", "most_join_asc"]
    ]
  end

  def Event.most_like
    select("events.*, count(like_events.event_id) as likes_count")
      .joins(:like_events).group(:event_id).order("likes_count DESC").limit(4)
  end

  def Event.most_join
    select("events.*, count(join_events.event_id) as joins_count")
      .joins(:join_events).group(:event_id).order("joins_count DESC").limit(4)
  end

  scope :event_manage, -> {select(:id, :title, :date_start, :date_end, :user_id,
    :created_at, :updated_at, :is_open)}
end
