require 'rails_helper'

RSpec.describe Tourist, type: :model do
  describe "is created" do
    context "to be valid" do
      it "email, password, username" do
        expect(build(:tourist)).to be_valid
      end
    end

    context "to be invalid" do
      it "without a email" do
        tourist = build(:tourist, email: nil)
        tourist.valid?
        expect(tourist.errors[:email]).to include("メールアドレスを入力してください。")
      end

      it "with a email over 255 character length" do
        tourist = build(:tourist, email: "x" * 266)
        tourist.valid?
        expect(tourist.errors[:email]).to include("メールアドレスは255文字以下で入力してください。")
      end

      it "with an inappropreate email format" do
        tourist = build(:tourist, email: "testgmail.com")
        tourist.valid?
        expect(tourist.errors[:email]).to include("正しいフォーマットを入力してください。")
      end

      it "with a duplicate email address" do
        FactoryBot.create(:tourist, email: "test@gmail.com")
        tourist = FactoryBot.build(:tourist, email: "test@gmail.com")
        tourist.valid?
        expect(tourist.errors[:email]).to include("このメールアドレスはすでに登録されています。")
      end

      it "with the length of password less than 6" do
        tourist = build(:tourist, password: "12345")
        tourist.valid?
        expect(tourist.errors[:password]).to include("パスワードは6文字以上で入力してください。")
      end

      it "without username" do
        tourist = build(:tourist, username: nil)
        tourist.valid?
        expect(tourist.errors[:username]).to include("ユーザー名を入力してください。")
      end
    end
  end
end
