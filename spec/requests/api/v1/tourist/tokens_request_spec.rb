require 'rails_helper'

RSpec.describe "Api::V1::Tourist::Tokens", type: :request do
  describe "POST #create" do
    before do
      @tourist = FactoryBot.create(:tourist)
    end

    context "valid with parameter" do
      it "responds successfully" do
        post api_v1_tourist_tokens_url, params: { tourist: { email: @tourist.email, password: @tourist.password} }
        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)
        expect(json["email"]).to eq @tourist.email
      end
    end

    context "invalid with parameter" do
      it "responds 401 error" do
        post api_v1_tourist_tokens_url, params: { tourist: { email: @tourist.email, password: "testgmail.com" } }
        expect(response).to have_http_status "401"
      end
    end
  end
end
