require 'rails_helper'

RSpec.describe User, type: :model do
  describe "is created" do
    context "to be valid" do
      it "email and password" do
        expect(build(:user)).to be_valid
      end
    end

    context "to be invalid" do
      it "without a email" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("メールアドレスを入力してください。")
      end

      it "with a email over 255 character length" do
        user = build(:user, email: "x" * 266)
        user.valid?
        expect(user.errors[:email]).to include("メールアドレスは255文字以下で入力してください。")
      end

      it "with an inappropreate email format" do
        user = build(:user, email: "testgmail.com")
        user.valid?
        expect(user.errors[:email]).to include("正しいフォーマットを入力してください。")
      end

      it "with a duplicate email address" do
        FactoryBot.create(:user, email: "test@gmail.com")
        user = FactoryBot.build(:user, email: "test@gmail.com")
        user.valid?
        expect(user.errors[:email]).to include("このメールアドレスはすでに登録されています。")
      end

      it "with the length of password less than 6" do
        user = build(:user, password: "12345")
        user.valid?
        expect(user.errors[:password]).to include("パスワードは6文字以上で入力してください。")
      end
    end
  end
end
