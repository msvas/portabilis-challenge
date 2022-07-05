# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  # Name must be informed when dealing with object
  validates :name, presence: true

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
