require 'rails_helper'

RSpec.describe "Api::V1::Tourist::Reviews", type: :request do
  describe "POST #create" do
    let(:user) { FactoryBot.create(:user) }
    let(:tourist) { FactoryBot.create(:tourist) }

    context "valid with parameter" do
      it "responds successfully" do
        post api_v1_tourist_reviews_url,
            params: { review: FactoryBot.attributes_for(:review, user_id: user.id, tourist_id: tourist.id)},
            headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json["lang"]).to eq "ja"
        expect(json["postReview"]).to eq "ここは最高によかった"
        expect(json["rating"]).to eq 3
      end

      it "adds a review" do
        expect{
          post api_v1_tourist_reviews_url,
            params: { review: FactoryBot.attributes_for(:review, user_id: user.id, tourist_id: tourist.id)},
            headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        }.to change(Review, :count).by(1)
      end
    end

    context "invalid with parameter" do
      it "responds 422 error" do
        post api_v1_tourist_reviews_url,
            params: { review: FactoryBot.attributes_for(:review, user_id: user.id, tourist_id: tourist.id, post_review: "")},
            headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        expect(response).to have_http_status "422"
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { FactoryBot.create(:user) }
    let(:tourist) { FactoryBot.create(:tourist) }
    let(:review) { FactoryBot.create(:review, user_id: user.id, tourist_id: tourist.id) }

    context "as authorized tourist" do
      it "responds successfully" do
        delete api_v1_tourist_review_url(review.id), headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        expect(response).to have_http_status(:no_content)
      end

      it "remove a review" do
        review.reload
        expect{
          delete api_v1_tourist_review_url(review.id), headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        }.to change(Review, :count).by(-1)
      end
    end

    context "as unauthorized user(anonymous)" do
      it "responds 403 error" do
        delete api_v1_tourist_review_url(review.id)
        expect(response).to have_http_status "403"
      end
    end
  end
end
