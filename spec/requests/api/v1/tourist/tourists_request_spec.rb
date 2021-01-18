require 'rails_helper'

RSpec.describe "Api::V1::Tourist::Tourists", type: :request do
  describe "POST #create" do
    context "valid with parameter" do
      it "responds successfully" do
        post api_v1_tourist_tourists_url, params: { tourist: FactoryBot.attributes_for(:tourist1) }
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json["email"]).to eq "example1@gmail.com"
      end

      it "adds a tourist" do
        expect{
          post api_v1_tourist_tourists_url, params: { tourist: FactoryBot.attributes_for(:tourist1) }
        }.to change(Tourist, :count).by(1)
      end
    end

    context "invalid with parameter" do
      it "responds 422 error" do
        post api_v1_tourist_tourists_url, params: { tourist: FactoryBot.attributes_for(:tourist, email: "xxxxxxx") }
        expect(response).to have_http_status "422"
      end
    end
  end

  describe "PATCH #update" do
    let(:tourist) { FactoryBot.create(:tourist) }

    context "as authorized tourist" do
      it "responds successfully" do
        patch api_v1_tourist_tourist_url(tourist.id),
              params: { tourist: FactoryBot.attributes_for(:tourist, email: "test2@gmail.com", sex: 1, birth: 1998, country: "US", lang: "en") },
              headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        expect(response).to have_http_status(:success)
        tourist.reload
        expect(tourist.email).to eq "test2@gmail.com"
        expect(tourist.sex).to eq 1
        expect(tourist.birth).to eq 1998
        expect(tourist.country).to eq "US"
        expect(tourist.lang).to eq "en"
      end

      it "with invalid email responds 422 error" do
        patch api_v1_tourist_tourist_url(tourist.id),
              params: { tourist: FactoryBot.attributes_for(:tourist, email: "test2gmail.com", sex: 1, birth: 1998, country: "US", lang: "en") },
              headers: { Authorization: JsonWebToken.encode(tourist_id: tourist.id)}
        expect(response).to have_http_status "422"
      end
    end

    context "as unauthorized user(anonymous)" do
      it "responds 403 error" do
        patch api_v1_tourist_tourist_url(tourist.id),
              params: { tourist: FactoryBot.attributes_for(:tourist, email: "test2@gmail.com", sex: 1, birth: 1998, country: "US", lang: "en") }
        expect(response).to have_http_status "403"
      end
    end
  end
end
