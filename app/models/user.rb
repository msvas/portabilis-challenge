# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  # Name must be informed when dealing with object
  validates :name, presence: true
  # Email must be unique - database already checks that, but safety always comes first ;)
  validates :email, uniqueness: true

  # Scopes to help when retrieving data
  scope :admins, -> { where(role: User.roles['Admin']) }
  scope :regulars, -> { where(role: User.roles['Regular']) }
  scope :active_users, -> { where(role: User.statuses['Active']) }
  scope :suspended_users, -> { where(role: User.statuses['Suspended']) }

  # Scopes to order data
  scope :order_by_name, -> { order(name: :desc) }
  scope :order_by_email, -> { order(email: :desc) }
  scope :order_by_role, -> { order(role: :desc) }

  # Uses callback to send welcome email
  after_create_commit :send_welcome_email

  # Column in the DB to control user role
  enum role: {
    'Regular': 0,
    'Admin': 1,
  }

  # User can have different statuses
  enum status: {
    'Active': 0,
    'Suspended': 1,
    'Removed': 2
  }

  # Class function to search for users (and we can test it)
  def self.search_users(keyword)
    results = nil
    if keyword.present?
      results = User.where('unaccent(name) ILIKE unaccent(?) OR email ILIKE (?)',
                            "%#{keyword}%", "%#{keyword}%")
    end
    results
  end

  # Checks if instance is admin
  def admin?
    self.role == 'Admin'
  end

  # Checks if instance is active
  def active?
    self.status == 'Active'
  end

  private

  # Sends welcome email using background processing
  def send_welcome_email
    UserMailer.welcome(self).deliver_later
  end

end
