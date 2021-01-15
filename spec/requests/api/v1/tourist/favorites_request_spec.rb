require 'rails_helper'

RSpec.describe "Api::V1::Tourist::Favorites", type: :request do
  describe "POST #create" do
    let(:user) { FactoryBot.create(:user) }
    let(:tourist) { FactoryBot.create(:tourist) }

    context "valid with parameter" do
      it "responds successfully" do
        post api_v1_tourist_favorites_url,
            params: { favorite: { user_id: user.id }},
            headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        p json
      end

      it "adds a favorite" do
        expect{
          post api_v1_tourist_favorites_url,
            params: { favorite: { user_id: user.id }},
            headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        }.to change(Favorite, :count).by(1)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { FactoryBot.create(:user) }
    let(:tourist) { FactoryBot.create(:tourist) }

    before do
      @favorite = Favorite.create(user_id: user.id, tourist_id: tourist.id)
    end

    context "as authorized tourist" do
      it "responds successfully" do
        delete api_v1_tourist_favorite_url(@favorite.id), headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        expect(response).to have_http_status(:no_content)
      end

      it "remove a review" do
        expect{
          delete api_v1_tourist_favorite_url(@favorite.id), headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        }.to change(Favorite, :count).by(-1)
      end
    end

    context "as unauthorized user(anonymous)" do
      it "responds 403 error" do
        delete api_v1_tourist_favorite_url(@favorite.id)
        expect(response).to have_http_status "403"
      end
    end
  end
end
