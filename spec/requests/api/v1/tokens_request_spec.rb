require 'rails_helper'

RSpec.describe "Api::V1::Tokens", type: :request do
  describe "POST #create" do
    before do
      @user = FactoryBot.create(:user)
    end

    context "valid with parameter" do
      it "responds successfully" do
        post api_v1_tokens_url, params: { user: { email: @user.email, password: @user.password} }
        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)
        expect(json["email"]).to eq @user.email
      end
    end

    context "invalid with parameter" do
      it "responds 401 error" do
        post api_v1_tokens_url, params: { user: { email: @user.email, password: "testgmail.com" } }
        expect(response).to have_http_status "401"
      end
    end
  end
end
