require 'rails_helper'

RSpec.describe MultiProfile, type: :model do
  describe "is created" do
    let(:user) { FactoryBot.create(:user) }

    context "to be valid" do
      it "with username, self_intro, address, entrance_fee, business_hours, holiday, translated" do
        multi_profile = build(:multi_profile, user_id: user.id)
        expect(multi_profile).to be_valid
      end
    end

    context "to be invalid" do
      it "with an inappropreate lang" do
        multi_profile = build(:multi_profile, user_id: user.id, lang: "xxx")
        multi_profile.valid?
        expect(multi_profile.errors[:lang]).to include("正しい言語を選択してください。")
      end

      it "with empty username" do
        multi_profile = build(:multi_profile, user_id: user.id, username: "")
        multi_profile.valid?
        expect(multi_profile.errors[:username]).to include("ユーザー名を入力してください。")
      end

      it "with the length of username more than 255 character" do
        multi_profile = build(:multi_profile, user_id: user.id, username: "x" * 256)
        multi_profile.valid?
        expect(multi_profile.errors[:username]).to include("ユーザー名は255文字以下で入力してください。")
      end

      it "with empty self_intro" do
        multi_profile = build(:multi_profile, user_id: user.id, self_intro: "")
        multi_profile.valid?
        expect(multi_profile.errors[:self_intro]).to include("ユーザー説明文を入力してください。")
      end

      it "with translated which does not satisfy 0, 1" do
        multi_profile = build(:multi_profile, user_id: user.id, translated: 2)
        multi_profile.valid?
        expect(multi_profile.errors[:translated]).to include("翻訳フラグは0, 1のどちらかを選択してください。")
      end
    end
  end
end
