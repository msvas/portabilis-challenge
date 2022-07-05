# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  # Column in the DB to control user role
  enum role: {
    'Regular': 0,
    'Admin': 1,
  }

  # User can have different statuses
  enum status: {
    'Registered': 0,
    'Active': 1,
    'Suspended': 2,
    'Removed': 3
  }
end
