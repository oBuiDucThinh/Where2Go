class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :picture, PictureUploader
  attr_accessor :remember_token
  attr_accessor :skip_password_validation
  has_many :events
  has_many :comments, dependent: :destroy
  has_many :events, through: :comments

  enum role: [:normal, :creator, :admin]

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: Settings.user.name.maximum}
  validates :email, presence: true,
    length: {maximum: Settings.user.email.maximum},
    format: {with: VALID_EMAIL_REGEX}
  validates :phone, presence: true,
    length: {maximum: Settings.user.phone.maximum}

  scope :load_info_to_edit, ->{select :name, :email, :phone}
  scope :load_to_show_ordered_by_name,
    ->{select :id, :name, :email, :role, :created_at and order name: :asc}
  scope :new_user_this_month, ->{where :created_at => Time.now.beginning_of_month..Time.now.end_of_month}

  def User.has_most_events
    select("users.*, count(events.id) as events_count")
    .joins(:events).group(:user_id).order("events_count DESC").limit(1).first
  end
end
