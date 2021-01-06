require 'rails_helper'

RSpec.describe MultiExhibit, type: :model do
  describe "is created" do
    let(:user) { FactoryBot.create(:user) }
    let(:exhibit) { FactoryBot.create(:exhibit, user_id: user.id)}

    context "to be valid" do
      it "with lang, name and description" do
        multi_exhibit = build(:multi_exhibit, exhibit_id: exhibit.id)
        expect(multi_exhibit).to be_valid
      end
    end

    context "to be invalid" do
      it "with an inappropreate lang" do
        multi_exhibit = build(:multi_exhibit, exhibit_id: exhibit.id, lang: "xxx")
        multi_exhibit.valid?
        expect(multi_exhibit.errors[:lang]).to include("正しい言語を選択してください。")
      end

      it "with empty name" do
        multi_exhibit = build(:multi_exhibit, exhibit_id: exhibit.id, name: "")
        multi_exhibit.valid?
        expect(multi_exhibit.errors[:name]).to include("対象物の名称を入力してください。")
      end

      it "with the length of name more than 255 character" do
        multi_exhibit = build(:multi_exhibit, exhibit_id: exhibit.id, name: "x" * 256)
        multi_exhibit.valid?
        expect(multi_exhibit.errors[:name]).to include("対象物の名称は255文字以下で入力してください。")
      end

      it "with empty description" do
        multi_exhibit = build(:multi_exhibit, exhibit_id: exhibit.id, description: "")
        multi_exhibit.valid?
        expect(multi_exhibit.errors[:description]).to include("対象物の説明を入力してください。")
      end
    end
  end
end
