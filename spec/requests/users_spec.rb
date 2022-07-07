require 'rails_helper'

RSpec.describe "Users", type: :request do
  include Devise::Test::IntegrationHelpers

  describe "POST /api/v1/users/search" do
    it "does not search users when not logged in" do
      post "/api/v1/users/search"
      expect(response).to have_http_status(:unauthorized)
    end

    it "searches users when logged in" do
      user1 = FactoryBot.create(:user, name: 'bb', email: 'bb@bb.com')
      user2 = FactoryBot.create(:user, name: 'aa', email: 'aa@aa.com')
      user3 = FactoryBot.create(:user, name: 'zz', email: 'zz@zz.com')

      # Helper that generate auth tokens to send with requests when testing
      auth_headers1 = user1.create_new_auth_token

      post "/api/v1/users/search", params: { keyword: 'aa', sort: [''] }, headers: auth_headers1
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end

    it "sorts users by name when param is informed" do
      user1 = FactoryBot.create(:user, name: 'bb', email: 'bb@bb.com')
      user2 = FactoryBot.create(:user, name: 'aa', email: 'aa@aa.com')
      user3 = FactoryBot.create(:user, name: 'zz', email: 'zz@zz.com')

      # Helper that generate auth tokens to send with requests when testing
      auth_headers1 = user1.create_new_auth_token

      post "/api/v1/users/search", params: { keyword: '', sort: ['name'] }, headers: auth_headers1
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)[0]['name']).to eq('aa')
    end

    it "sorts users by email when param is informed" do
      user1 = FactoryBot.create(:user, name: 'bb', email: 'bb@bb.com')
      user2 = FactoryBot.create(:user, name: 'aa', email: 'aa@aa.com')
      user3 = FactoryBot.create(:user, name: 'zz', email: 'zz@zz.com')

      # Helper that generate auth tokens to send with requests when testing
      auth_headers1 = user1.create_new_auth_token

      post "/api/v1/users/search", params: { keyword: '', sort: ['email'] }, headers: auth_headers1
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)[0]['name']).to eq('aa')
    end

    it "sorts users by role when param is informed" do
      admin1 = FactoryBot.create(:user, :admin, name: 'zz', email: 'zz@zz.com')
      user1 = FactoryBot.create(:user, name: 'bb', email: 'bb@bb.com')

      # Helper that generate auth tokens to send with requests when testing
      auth_headers1 = user1.create_new_auth_token

      post "/api/v1/users/search", params: { keyword: '', sort: ['role'] }, headers: auth_headers1
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)[0]['name']).to eq('bb')
    end
  end

  describe "GET /api/v1/users" do
    let(:user1) { FactoryBot.create(:user, name: 'bb', email: 'bb@bb.com') }
    let(:user2) { FactoryBot.create(:user, name: 'aa', email: 'aa@aa.com') }
    let(:user3) { FactoryBot.create(:user, name: 'zz', email: 'zz@zz.com') }

    # Helper that generate auth tokens to send with requests when testing
    let(:auth_headers1) { user1.create_new_auth_token }

    it "does not retrieve users when not logged in" do
      get "/api/v1/users"
      expect(response).to have_http_status(:unauthorized)
    end

    it "retrieves users when logged in" do
      get "/api/v1/users", headers: auth_headers1
      expect(response).to have_http_status(:ok)
    end

  end
end
