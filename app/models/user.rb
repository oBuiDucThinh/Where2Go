class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :user_events
  has_many :events, through: :user_events
  has_many :comments, dependent: :destroy
  has_many :categories, through: :user_categories
  has_many :user_categories
  accepts_nested_attributes_for :categories

  enum role: [:normal, :creator]
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: Settings.user.name.maximum}
  validates :email, presence: true, length: {maximum: Settings.user.email.maximum},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :phone, presence: true, length: {maximum: Settings.user.phone.maximum}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.user.password.minimum}

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attributes remember_digest: nil
  end
end
