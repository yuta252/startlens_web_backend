require 'rails_helper'

RSpec.describe Exhibit, type: :model do
  describe "is created" do
    let(:user) { FactoryBot.create(:user) }

    context "to be valid" do
      it "with user_id" do
        exhibit = build(:exhibit, user_id: user.id)
        expect(exhibit).to be_valid
      end
    end
  end
end
