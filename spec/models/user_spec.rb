require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do
    it "is valid with attributes" do
      expect(FactoryBot.create(:user, name: 'test')).to be_valid
    end
  end

  describe "#search_users" do
    user1 = FactoryBot.create(:user, name: 'test1')
    user2 = FactoryBot.create(:user, name: 'test2')

    it "searches and finds users by name" do
      expect(User.search_users('test1').count).to eq(1)
    end

    it "searches and finds users by email" do
      expect(User.search_users(user1.email).count).to eq(1)
    end

    it "searches using special characters" do
      user3 = FactoryBot.create(:user, name: 'José')
      expect(User.search_users('jose').count).to eq(1)
    end

    it "does not find users if there is no keyword match" do
      expect(User.search_users('nomatch').count).to eq(0)
    end
  end
end
