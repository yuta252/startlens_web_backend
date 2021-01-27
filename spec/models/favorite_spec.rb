require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "is created" do
    let(:user) { FactoryBot.create(:user) }
    let(:tourist) { FactoryBot.create(:tourist) }

    context "to be valid" do
      it "with appropreate parameter" do
        favorite = Favorite.new(user_id: user.id, tourist_id: tourist.id)
        expect(favorite).to be_valid
      end
    end

    context "to be invalid" do
      it "duplicated registration" do
        Favorite.create(user_id: user.id, tourist_id: tourist.id)
        favorite = Favorite.new(user_id: user.id, tourist_id: tourist.id)
        favorite.valid?
        expect(favorite.errors[:tourist_id]).to include("既にお気に入り登録されています。")
      end
    end
  end
end
