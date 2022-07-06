# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  # Name must be informed when dealing with object
  validates :name, presence: true

  # Scopes to help when retrieving data
  scope :admins, -> { where(role: User.roles['Admin']) }
  scope :regulars, -> { where(role: User.roles['Regular']) }
  scope :active_users, -> { where(role: User.statuses['Active']) }
  scope :suspended_users, -> { where(role: User.statuses['Suspended']) }

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

  def admin?
    self.role == 'Admin'
  end
end
