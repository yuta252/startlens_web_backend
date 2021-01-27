require 'rails_helper'

RSpec.describe "Api::V1::MultiProfiles", type: :request do
  describe "GET /api/v1/multi_profiles" do
    let(:user) { FactoryBot.create(:user)}

    it "responds successfully" do
      FactoryBot.create(:multi_profile, user_id: user.id)
      FactoryBot.create(:multi_profile2, user_id: user.id)
      get api_v1_multi_profiles_url, headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.length).to eq 2
    end
  end

  describe "POST /api/v1/multi_profiles" do
    let(:user) { FactoryBot.create(:user)}

    context "valid with parameter" do

      it "responds successfully", focus:true do
        post api_v1_multi_profiles_url, params: { multi_profile: FactoryBot.attributes_for(:multi_profile, user_id: user.id) },
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)
        expect(json["username"]).to eq "明治神宮"
      end

      it "adds a multi profile" do
        expect{
          post api_v1_multi_profiles_url, params: { multi_profile: FactoryBot.attributes_for(:multi_profile, user_id: user.id) },
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        }.to change(MultiProfile, :count).by(1)
      end
    end

    context "invalid with parameter" do
      it "responds 422 error" do
        post api_v1_multi_profiles_url, params: { multi_profile: FactoryBot.attributes_for(:multi_profile, user_id: user.id, lang: "xxx") },
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        expect(response).to have_http_status "422"
      end
    end
  end

  describe "PATCH /api/v1/multiprofiles/id" do
    let(:user) { FactoryBot.create(:user)}
    let(:multi_profile) { FactoryBot.create(:multi_profile, user_id: user.id)}

    context "as authorized user" do
      it "responds successfully" do
        patch api_v1_multi_profile_url(multi_profile.id),
              params: { multi_profile: FactoryBot.attributes_for(:multi_profile, lang: "en") },
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        expect(response).to have_http_status(:success)
        expect(multi_profile.reload.lang).to eq "en"
      end

      it "with invalid email responds 422 error" do
        patch api_v1_multi_profile_url(multi_profile.id),
              params: { multi_profile: FactoryBot.attributes_for(:multi_profile, username: "x" * 266) },
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        expect(response).to have_http_status "422"
      end
    end

    context "as unautorized user" do
      it "responds 403 error" do
        patch api_v1_multi_profile_url(multi_profile.id),
              params: { multi_profile: FactoryBot.attributes_for(:multi_profile, self_intro: "sample") }
        expect(response).to have_http_status "403"
      end
    end

  end

  describe "DELETE /api/v1/multiprofiles/id" do
    let(:user) { FactoryBot.create(:user)}
    let(:multi_profile) { FactoryBot.create(:multi_profile, user_id: user.id)}

    context "as authorized user" do
      it "responds successfully " do
        delete api_v1_multi_profile_url(multi_profile.id),
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        expect(response).to have_http_status :no_content
      end

      it "delete a multi profile" do
        multi_profile2 = FactoryBot.create(:multi_profile2, user_id: user.id)
        expect{
          delete api_v1_multi_profile_url(multi_profile2.id),
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        }.to change(MultiProfile, :count).by(-1)
      end
    end

    context "as unautorized user" do
      it "responds 403 error" do
        delete api_v1_multi_profile_url(multi_profile.id)
        expect(response).to have_http_status "403"
      end
    end
  end
end
