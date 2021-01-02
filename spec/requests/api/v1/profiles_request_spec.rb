require 'rails_helper'

RSpec.describe "Api::V1::Profiles", type: :request do
  describe "GET #show" do
    before do
      @user = FactoryBot.create(:user)
      @profile = FactoryBot.create(:profile, user_id: @user.id)
    end

    context "as authorized user" do
      it "responds successfully" do
        get api_v1_profile_url(@profile.id),
            headers: { Authorization: JsonWebToken.encode(user_id: @user.id)}
        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)
      end
    end

    context "as unauthorized user" do
      it "responds 403 error" do
        get api_v1_profile_url(@profile.id)
        expect(response).to have_http_status "403"
      end
    end
  end

  describe "PATCH #update" do
    before do
      @user = FactoryBot.create(:user)
      @profile = FactoryBot.create(:profile, user_id: @user.id)
    end

    context "as authorized user" do
      it "responds successfully" do
        patch api_v1_profile_url(@profile.id),
              params: { profile: FactoryBot.attributes_for(:profile, major_category: 4, telephone: "08059876453", company_site: "https://goooo.com") },
              headers: { Authorization: JsonWebToken.encode(user_id: @user.id)}
        expect(response).to have_http_status(:success)
        expect(@profile.reload.major_category).to eq 4
        expect(@profile.reload.telephone).to eq "08059876453"
        expect(@profile.reload.company_site).to eq "https://goooo.com"
      end
    end

    context "as unauthorized user(anonymous)" do
      it "responds 403 error" do
        patch api_v1_profile_url(@profile.id),
              params: { profile: FactoryBot.attributes_for(:profile, major_category: 4, telephone: "08059876453", company_site: "https://goooo.com") }
        expect(response).to have_http_status "403"
      end
    end
  end
end
