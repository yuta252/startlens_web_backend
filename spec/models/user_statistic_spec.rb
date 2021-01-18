require 'rails_helper'

RSpec.describe UserStatistic, type: :model do
  describe "is created" do
    let(:user) { FactoryBot.create(:user) }
    let(:tourist) { FactoryBot.create(:tourist) }

    context "to be valid" do
      it "with user_id, tourist_id" do
        expect(build(:user_statistic, user_id: user.id, tourist_id: tourist.id)).to be_valid
      end

      it "with creating today although yesterday is created" do
        FactoryBot.create(:user_statistic, user_id: user.id, tourist_id: tourist.id, created_at: Time.zone.now.ago(3.days))
        FactoryBot.create(:user_statistic, user_id: user.id, tourist_id: tourist.id, created_at: Time.zone.now.yesterday)
        user_statistic3 = FactoryBot.build(:user_statistic, user_id: user.id, tourist_id: tourist.id, created_at: Time.zone.now)
        expect(user_statistic3).to be_valid
      end

      it "with creating today although tomorrow is created" do
        FactoryBot.create(:user_statistic, user_id: user.id, tourist_id: tourist.id, created_at: Time.zone.now.tomorrow)
        FactoryBot.create(:user_statistic, user_id: user.id, tourist_id: tourist.id, created_at: Time.zone.now.since(2.days))
        user_statistic = FactoryBot.build(:user_statistic, user_id: user.id, tourist_id: tourist.id, created_at: Time.zone.now)
        expect(user_statistic).to be_valid
      end
    end

    context "to be invalid" do
      it "can_not_duplicated_date" do
        FactoryBot.create(:user_statistic, user_id: user.id, tourist_id: tourist.id, created_at: Time.zone.now)
        user_statistic = FactoryBot.build(:user_statistic, user_id: user.id, tourist_id: tourist.id, created_at: Time.zone.now)
        user_statistic.valid?
        expect(user_statistic.errors[:created_at]).to include("登録日が重複しています")
      end
    end
  end
end
