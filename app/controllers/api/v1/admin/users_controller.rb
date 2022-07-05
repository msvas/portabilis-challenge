# frozen_string_literal: true

module Api::V1::Admin
  # Controller with methods only available to admins
  class UsersControllers < ApplicationController
    # Devise method that verifies if user is logged in
    before_action :authenticate_user!

    # Destroys user
    def destroy

    end

    # Changes user status to suspended
    def suspend

    end

  end
end
