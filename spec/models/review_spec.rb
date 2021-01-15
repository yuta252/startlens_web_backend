require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "is created" do
    let(:review) { FactoryBot.create(:review) }
    let(:user) { FactoryBot.create(:user) }
    let(:tourist) { FactoryBot.create(:tourist) }

    context "to be valid" do
      it "with lang, post_review, rating" do
        expect(build(:review, user_id: user.id, tourist_id: tourist.id)).to be_valid
      end
    end

    context "to be invalid" do
      it "without post_review" do
        review = build(:review, user_id: user.id, tourist_id: tourist.id, post_review: "")
        review.valid?
        expect(review.errors[:post_review]).to include("レビューを入力してください。")
      end

      it "without lang" do
        review = build(:review, user_id: user.id, tourist_id: tourist.id, lang: "")
        review.valid?
        expect(review.errors[:lang]).to include("言語を入力してください。")
      end

      it "without rating" do
        review = build(:review, user_id: user.id, tourist_id: tourist.id, rating: "")
        review.valid?
        expect(review.errors[:rating]).to include("評価を入力してください。")
      end

      it "without rating more than 5" do
        review = build(:review, user_id: user.id, tourist_id: tourist.id, rating: 6)
        review.valid?
        expect(review.errors[:rating]).to include("評価は0以上5以下の数字を入力してください。")
      end

      it "without rating less than 0" do
        review = build(:review, user_id: user.id, tourist_id: tourist.id, rating: -1)
        review.valid?
        expect(review.errors[:rating]).to include("評価は0以上5以下の数字を入力してください。")
      end

      it "duplicated review at same post by same tourist" do
        FactoryBot.create(:review2, user_id: user.id, tourist_id: tourist.id)
        review = build(:review, user_id: user.id, tourist_id: tourist.id)
        review.valid?
        expect(review.errors[:tourist_id]).to include("既にレビューが投稿されています。")
      end
    end
  end

  describe "self.review_static" do
    it "any reviews isn't posted, returns 0" do
      user = FactoryBot.create(:user)
      static = Review.review_static(user.id)
      expect(static[:average]).to eq 0.0
      expect(static[:count]).to eq 0
    end

    it "some reviews is posted, returns {average: 3.0, count: 3}" do
      user = FactoryBot.create(:user)
      tourist1 = FactoryBot.create(:tourist)
      tourist2 = FactoryBot.create(:tourist1)
      tourist3 = FactoryBot.create(:tourist2)
      reivew1 = FactoryBot.create(:review, user_id: user.id, tourist_id: tourist1.id)
      reivew2 = FactoryBot.create(:review2, user_id: user.id, tourist_id: tourist2.id)
      reivew3 = FactoryBot.create(:review3, user_id: user.id, tourist_id: tourist3.id)

      static = Review.review_static(user.id)
      expect(static[:average]).to eq 3.0
      expect(static[:count]).to eq 3
    end

    it "some reviews is posted, returns {average: 2.0, count: 2}" do
      user = FactoryBot.create(:user)
      tourist1 = FactoryBot.create(:tourist)
      tourist3 = FactoryBot.create(:tourist2)
      reivew1 = FactoryBot.create(:review, user_id: user.id, tourist_id: tourist1.id)
      reivew3 = FactoryBot.create(:review3, user_id: user.id, tourist_id: tourist3.id)

      static = Review.review_static(user.id)
      expect(static[:average]).to eq 2.0
      expect(static[:count]).to eq 2
    end
  end

end
