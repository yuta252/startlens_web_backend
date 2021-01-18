require 'rails_helper'

RSpec.describe "Api::V1::Tourist::UserStatistics", type: :request do
  describe "POST #create" do
    let(:user) { FactoryBot.create(:user) }
    let(:tourist) { FactoryBot.create(:tourist) }

    context "valid with parameter" do
      it "responds successfully" do
        post api_v1_tourist_user_statistics_url,
            params: { user_statistic: { user_id: user.id }},
            headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["is_errors"]).to eq true
        expect(json["message"]).to eq "登録に成功しました"
      end

      it "adds a favorite" do
        expect{
          post api_v1_tourist_user_statistics_url,
            params: { user_statistic: { user_id: user.id }},
            headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        }.to change(UserStatistic, :count).by(1)
      end
    end

    context "invalid with parameter" do
      it "failed to create user statistic" do
        FactoryBot.create(:user_statistic, user_id: user.id, tourist_id: tourist.id, created_at: Time.zone.now)
        post api_v1_tourist_user_statistics_url,
              params: { user_statistic: { user_id: user.id }},
              headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["is_errors"]).to eq false
        expect(json["message"]).to eq "登録に失敗しました"
      end
    end
  end
end
