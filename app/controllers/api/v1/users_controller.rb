# frozen_string_literal: true

module Api::V1
  # Controller with methods only available to admins
  class UsersControllers < ApplicationController
    # Devise method that verifies if user is logged in
    before_action :authenticate_user!

    # Shows all users and loads useful info
    def index
      users = User.all.includes(:email, :name)
      render json: users, status: :ok
    end
  end
end
