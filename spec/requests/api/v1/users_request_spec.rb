require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "POST #create" do
    context "valid with parameter" do
      it "responds successfully" do
        post api_v1_users_url, params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)
        expect(json["email"]).to eq "sample1@gmail.com"
      end

      it "adds a user" do
        user = FactoryBot.attributes_for(:user)
        expect{
          post api_v1_users_url, params: { user: FactoryBot.attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it "adds a profile" do
        expect{
          post api_v1_users_url, params: { user: FactoryBot.attributes_for(:user) }
        }.to change(Profile, :count).by(1)
      end
    end

    context "invalid with parameter" do
      it "responds 422 error" do
        post api_v1_users_url, params: { user: FactoryBot.attributes_for(:user, email: "xxxxxxx") }
        expect(response).to have_http_status "422"
      end
    end
  end

  describe "PATCH #update" do
    let(:user) { FactoryBot.create(:user) }
    # let(:headers) { { CONTENT_TYPE: 'application/json', Authorization: 'token' } }
    context "as authorized user" do
      it "responds successfully" do
        patch api_v1_user_url(user.id),
              params: { user: FactoryBot.attributes_for(:user, email: "test2@gmail.com") },
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        expect(response).to have_http_status(:success)
        expect(user.reload.email).to eq "test2@gmail.com"
      end

      it "with invalid email responds 422 error" do
        patch api_v1_user_url(user.id),
              params: { user: FactoryBot.attributes_for(:user, email: "test2gmail.com") },
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        expect(response).to have_http_status "422"
      end
    end

    context "as unauthorized user(anonymous)" do
      it "responds 403 error" do
        patch api_v1_user_url(user.id),
              params: { user: FactoryBot.attributes_for(:user, email: "test2@gmail.com") }
        expect(response).to have_http_status "403"
      end
    end
  end
end
