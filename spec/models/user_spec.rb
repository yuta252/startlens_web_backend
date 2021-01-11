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

  describe "self.search method" do
    before do
      @user1 = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      @profile1 = create(:profile, user_id: @user1.id)
      @profile2 = create(:profile2, user_id: @user2.id)
      @profile3 = create(:profile3, user_id: @user3.id)
      @multi_profile1 = create(:multi_profile, user_id: @user1.id)
      @multi_profile2 = create(:multi_profile2, user_id: @user2.id)
      @multi_profile3 = create(:multi_profile3, user_id: @user3.id)
    end

    context "with parameter" do
      it "as a category" do
        expect(User.search({category: 27})).to include(@user3)
        expect(User.search({category: 27})).to_not include(@user1)
        expect(User.search({category: 27})).to_not include(@user2)
      end

      it "as a username" do
        expect(User.search({query: "明治神宮"})).to include(@user1)
        expect(User.search({query: "神宮"})).to include(@user1)
        expect(User.search({query: "明治"})).to include(@user1)
        expect(User.search({query: "明治神宮"})).to_not include(@user2)
        expect(User.search({query: "明治神宮"})).to_not include(@user3)
      end

      it "as a prefecture" do
        expect(User.search({prefecture: "東京"})).to include(@user1)
        expect(User.search({prefecture: "東京"})).to_not include(@user3)
        expect(User.search({prefecture: "神奈川"})).to include(@user3)
        expect(User.search({prefecture: "神奈川"})).to_not include(@user1)
      end
    end

    context "without parameter", focus:true do
      it "returns 3 spots" do
        expect(User.search({})).to include(@user1, @user2, @user3)
      end
    end
  end
end
