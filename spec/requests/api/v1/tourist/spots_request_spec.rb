require 'rails_helper'

RSpec.describe "Api::V1::Tourist::Spots", type: :request do
  describe "GET /api/v1/tourist/spots" do
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

    it "responds succesfully" do
      get api_v1_tourist_spots_url({})
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["data"].count).to eq 3
    end

    it "succeeds to search by a category" do
      get api_v1_tourist_spots_url({category: 27})
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["data"][0]["profile"]["majorCategory"]).to eq 27
    end

    it "succeeds to search by a username" do
      get api_v1_tourist_spots_url({query: "赤レンガ"})
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["data"][0]["multiProfiles"][0]["username"]).to eq "赤レンガ倉庫"
    end

    it "succeeds to search by a prefecture" do
      get api_v1_tourist_spots_url({prefecture: "神奈川"})
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["data"][0]["multiProfiles"][0]["addressPrefecture"]).to eq "神奈川"
    end

    it "succeeds to search by count" do
      get api_v1_tourist_spots_url({items: 2})
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["data"].count).to eq 2
    end
  end

  describe "GET /api/v1/tourist/spots/:id" do
    before do
      @user = FactoryBot.create(:user)
      @exhibit = FactoryBot.create(:exhibit, user_id: @user.id)
      @exhibit2 = FactoryBot.create(:exhibit2, user_id: @user.id)
      multi_exhibit = FactoryBot.create(:multi_exhibit, exhibit_id: @exhibit.id)
      multi_exhibit2 = FactoryBot.create(:multi_exhibit2, exhibit_id: @exhibit2.id)
    end

    it "responds successfully" do
      get api_v1_tourist_spot_url(@user.id)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json[0]["id"]).to eq @exhibit.id
      expect(json[1]["id"]).to eq @exhibit2.id
      expect(json[0]["multiExhibits"].count).to eq 1
      expect(json[1]["multiExhibits"].count).to eq 1
    end
  end
end
