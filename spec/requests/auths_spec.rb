require 'rails_helper'

RSpec.describe "Auths", type: :request do
  describe "POST /auth" do
    it "signs up user" do
      headers = { "CONTENT_TYPE" => "application/json" }
      data = '{ "email":"test2@test.com", "name":"test", "password":"123456", "password_confirmation":"123456" }'
      post "/auth", :params => data, :headers => headers
      expect(response).to have_http_status(:ok)
      expect(User.count).to eq(1)
    end

    it "does not sign up user if params are wrong" do
      headers = { "CONTENT_TYPE" => "application/json" }
      data = '{ "email":"test3@test.com", "password":"123456", "password_confirmation":"123456" }'
      post "/auth", :params => data, :headers => headers
      expect(response).to have_http_status(:unprocessable_entity)
      expect(User.count).to eq(0)
    end
  end

  describe "POST /auth/sign_in" do
    let(:user1) { FactoryBot.create(:user, name: 'test1') }

    it "signs in user" do
      headers = { "CONTENT_TYPE" => "application/json" }
      data = '{ "email":"' + user1.email + '", "password":"' + user1.password + '" }'
      post "/auth/sign_in", :params => data, :headers => headers
      expect(response).to have_http_status(:ok)
    end

    it "does not sign in user with wrong params" do
      headers = { "CONTENT_TYPE" => "application/json" }
      data = '{ "email":"' + user1.email + '", "password":"wrong" }'
      post "/auth/sign_in", :params => data, :headers => headers
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
