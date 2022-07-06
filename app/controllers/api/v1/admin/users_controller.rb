# frozen_string_literal: true

module Api::V1::Admin
  # Controller with methods only available to admins
  class UsersController < ApplicationController
    # Devise method that verifies if user is logged in
    before_action :authenticate_user!
    # Custom method to only allow admins to use these requests
    before_action :authenticate_admin!
    # Sets user before running method
    before_action :set_user

    # Destroys user
    def destroy
      if @user.destroy
        render json: { message: 'User deleted' }, status: :ok
      else
        render json: { error: 'Could not complete request' }, status: :unprocessable_entity
      end
    end

    # Changes user status to suspended
    def suspend
      status = User.statuses['Suspended']
      status = User.statuses['Active'] if @user.status == 'Suspended'
      if @user.update(status: status)
        render json: { message: 'Updated user status' }, status: :ok
      else
        render json: { error: 'Could not complete request' }, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(user_params[:id])
    end

    # Only allow the params we need for security reasons
    def user_params
      params.require(:user).permit(:id)
    end

  end
end
