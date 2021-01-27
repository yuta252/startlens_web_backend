require 'rails_helper'

RSpec.describe "Api::V1::Dashboards", type: :request do
  describe "GET /api/v1/dashboards" do
    let(:user) { FactoryBot.create(:user)}

    context "as authorized" do
      it "responds successfully" do
        get api_v1_dashboards_url, headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        expect(response).to have_http_status(:success)
      end
    end
  end
end
