# frozen_string_literal: true

module Api::V1
  # Controller with methods only available to admins
  class UsersController < ApplicationController
    # Devise method that verifies if user is logged in
    before_action :authenticate_user!
    # Custom method to only allow active users to use these requests
    before_action :user_active!
    # Caches index method so it can respond faster
    caches_action :index

    # Shows all users and loads useful info
    def index
      users = User.all
      render json: users, status: :ok
    end

    # Searches for users using a keyword
    def search
      if search_params[:keyword].present?
        results = User.search_users(search_params[:keyword])
      else
        results = User.all
      end
      # Uses variable to control direction value, if informed
      search_params[:direction].present? ? direction = search_params[:direction] : direction = ''
      # Orders data if 'sort' param is informed
      results = results.order(search_params[:sort].join(',') + " #{direction}") if search_params[:sort].present? && search_params[:sort].any?
      render json: results, status: :ok
    end

    private

    def search_params
      params.permit(:keyword, :direction, sort: [])
    end
  end
end
