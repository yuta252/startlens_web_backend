require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe "is created" do
    let(:user) { FactoryBot.create(:user) }

    context "to be valid" do
      it "major_category, telephone, company_site" do
        profile = build(:profile, user_id: user.id)
        expect(profile).to be_valid
      end
    end

    context "to be invalid" do
      it "with a major_category less than 0" do
        profile = build(:profile, major_category: -1)
        profile.valid?
        expect(profile.errors[:major_category]).to include("カテゴリーは0〜13の数字を入力してください。")
      end

      it "with a major_category more than 13" do
        profile = build(:profile, major_category: 14)
        profile.valid?
        expect(profile.errors[:major_category]).to include("カテゴリーは0〜13の数字を入力してください。")
      end

      it "with an inappropreate telephone number" do
        profile = build(:profile, telephone: "55555")
        profile.valid?
        expect(profile.errors[:telephone]).to include("ハイフンなしの正しいフォーマットで入力してください。")
      end

      it "with a site url that does not start with http or https" do
        profile = build(:profile, company_site: "google.com")
        profile.valid?
        expect(profile.errors[:company_site]).to include("正しいURLフォーマットを入力してください。")
      end
    end
  end
end
