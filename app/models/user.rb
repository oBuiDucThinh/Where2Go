class User < ApplicationRecord
  has_many :user_events
  has_many :events, through: :user_events
  has_many :comments, dependent: :destroy
  has_many :categories, through: :user_categories
  has_many :user_categories
  accepts_nested_attributes_for :categories

  enum role: {normal: 0, creator: 1}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,  presence: true, length: {maximum: Settings.user.name.maximum}
  validates :email, presence: true, length: {maximum: Settings.user.email.maximum},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :phone, presence: true, length: {maximum: Settings.user.phone.maximum}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.user.password.minimum}
end
