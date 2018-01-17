class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :remember_token
  attr_accessor :skip_password_validation
  has_many :events
  has_many :user_events
  has_many :comments, dependent: :destroy
  has_many :categories, through: :user_categories
  has_many :user_categories
  accepts_nested_attributes_for :categories

  enum role: [:normal, :creator, :admin]

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: Settings.user.name.maximum}
  validates :email, presence: true,
    length: {maximum: Settings.user.email.maximum},
    format: {with: VALID_EMAIL_REGEX}
  validates :phone, presence: true,
    length: {maximum: Settings.user.phone.maximum}
  validates :password, presence: true,
    length: {minimum: Settings.user.password.minimum},
    unless: :skip_password_validation
  # has_secure_password

  scope :load_info_to_edit, ->{select :name, :email, :phone}
  scope :load_to_show_ordered_by_name,
    ->{select :id, :name, :email, :role, :created_at and order name: :asc}

  # def User.digest string
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  #     BCrypt::Engine.cost
  #   BCrypt::Password.create string, cost: cost
  # end

  # def User.new_token
  #   SecureRandom.urlsafe_base64
  # end

  # def remember
  #   self.remember_token = User.new_token
  #   update_attributes remember_digest: User.digest(remember_token)
  # end

  # def authenticated? remember_token
  #   return false if remember_digest.nil?
  #   BCrypt::Password.new(remember_digest).is_password?(remember_token)
  # end

  # def forget
  #   update_attributes remember_digest: nil
  # end
end
