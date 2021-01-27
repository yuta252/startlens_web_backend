require 'rails_helper'

RSpec.describe "Api::V1::Tourist::ExhibitFavorites", type: :request do
  describe "POST #create" do
    let(:exhibit) { FactoryBot.create(:exhibit) }
    let(:tourist) { FactoryBot.create(:tourist) }

    context "valid with parameter" do
      it "responds successfully" do
        post api_v1_tourist_exhibit_favorites_url,
            params: { exhibit_favorite: { exhibit_id: exhibit.id }},
            headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        p json
      end

      it "adds a exhibit_favorite" do
        expect{
          post api_v1_tourist_exhibit_favorites_url,
            params: { exhibit_favorite: { exhibit_id: exhibit.id }},
            headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        }.to change(ExhibitFavorite, :count).by(1)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:exhibit) { FactoryBot.create(:exhibit) }
    let(:tourist) { FactoryBot.create(:tourist) }

    before do
      @exhibit_favorite = ExhibitFavorite.create(exhibit_id: exhibit.id, tourist_id: tourist.id)
    end

    context "as authorized tourist" do
      it "responds successfully" do
        delete api_v1_tourist_exhibit_favorite_url(@exhibit_favorite.id), headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        expect(response).to have_http_status(:no_content)
      end

      it "remove a review" do
        expect{
          delete api_v1_tourist_exhibit_favorite_url(@exhibit_favorite.id), headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        }.to change(ExhibitFavorite, :count).by(-1)
      end
    end

    context "as unauthorized user(anonymous)" do
      it "responds 403 error" do
        delete api_v1_tourist_exhibit_favorite_url(@exhibit_favorite.id)
        expect(response).to have_http_status "403"
      end
    end
  end
end
