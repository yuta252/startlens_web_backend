require 'rails_helper'

RSpec.describe "Api::V1::Tourist::Exhibits", type: :request do
  describe "GET /api/v1/tourist/exhibit/:id" do
    before do
      @user = FactoryBot.create(:user)
      @exhibit = FactoryBot.create(:exhibit, user_id: @user.id)
      @exhibit2 = FactoryBot.create(:exhibit2, user_id: @user.id)
      multi_exhibit = FactoryBot.create(:multi_exhibit, exhibit_id: @exhibit.id)
      multi_exhibit2 = FactoryBot.create(:multi_exhibit2, exhibit_id: @exhibit2.id)
    end

    it "responds successfully" do
      get api_v1_tourist_exhibit_url(@user.id)
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json[0]["id"]).to eq @exhibit.id
      expect(json[1]["id"]).to eq @exhibit2.id
      expect(json[0]["multiExhibits"].count).to eq 1
      expect(json[1]["multiExhibits"].count).to eq 1
    end
  end
end
