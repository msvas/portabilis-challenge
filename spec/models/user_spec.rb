require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Validations" do
    it "is valid with attributes" do
      expect(FactoryBot.create(:user, name: 'test')).to be_valid
    end
  end
end
