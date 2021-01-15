require 'rails_helper'

RSpec.describe ExhibitFavorite, type: :model do
  describe "is created" do
    let(:tourist) { FactoryBot.create(:tourist) }
    let(:exhibit) { FactoryBot.create(:exhibit) }

    context "to be valid" do
      it "with appropreate parameter" do
        exhibit_favorite = ExhibitFavorite.new(tourist_id: tourist.id, exhibit_id: exhibit.id)
        expect(exhibit_favorite).to be_valid
      end
    end

    context "to be invalid" do
      it "duplicated registration" do
        ExhibitFavorite.create(tourist_id: tourist.id, exhibit_id: exhibit.id)
        exhibit_favorite = ExhibitFavorite.new(tourist_id: tourist.id, exhibit_id: exhibit.id)
        exhibit_favorite.valid?
        expect(exhibit_favorite.errors[:tourist_id]).to include("既にお気に入り登録されています。")
      end
    end
  end
end
