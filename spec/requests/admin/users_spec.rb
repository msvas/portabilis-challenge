require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:users) { FactoryBot.create_list(:user, 5) }
  let(:admin1) { FactoryBot.create(:user, :admin) }

  # Helpers that generate auth tokens to send with requests when testing
  let(:auth_headers1) { users.first.create_new_auth_token }
  let(:auth_headers_admin1) { admin1.create_new_auth_token }

  describe "GET /api/v1/admin/users/:user_id/suspend" do

    it "does not allow regular users to suspend users" do
      get "/api/v1/admin/users/#{users.second.id}/suspend", headers: auth_headers1
      expect(response).to have_http_status(:unauthorized)
    end

    it "allows admin to suspend users" do
      get "/api/v1/admin/users/#{users.second.id}/suspend", headers: auth_headers_admin1
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['status']).to eq('Suspended')
    end
  end

  describe "DELETE /api/v1/admin/users/:id" do

    it "does not allow regular users to delete users" do
      delete "/api/v1/admin/users/#{users.second.id}", headers: auth_headers1
      expect(response).to have_http_status(:unauthorized)
    end

    it "allows admin to to delete users" do
      delete "/api/v1/admin/users/#{users.second.id}", headers: auth_headers_admin1
      expect(User.count).to eq(5)
    end
  end
end
