# frozen_string_literal: true

module Api::V1
  # Controller with methods only available to admins
  class UsersController < ApplicationController
    # Devise method that verifies if user is logged in
    before_action :authenticate_user!

    # Shows all users and loads useful info
    def index
      if params[:sort].present?
        # Orders records by the column name informed in the 'sort' param
        users = User.all
                    .order(params[:sort])
      else
        users = User.all
      end
      render json: users, status: :ok
    end

    # Searches for users using a keyword
    def search
      results = User.search_users(search_params[:keyword])
      render json: results, status: :ok
    end

    private

    def search_params
      params.require(:keyword)
    end
  end
end
