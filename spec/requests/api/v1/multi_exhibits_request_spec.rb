require 'rails_helper'

RSpec.describe "Api::V1::MultiExhibits", type: :request do
  describe "POST /api/v1/multi_exhibits" do
    let(:user) { FactoryBot.create(:user) }
    let(:exhibit) { FactoryBot.create(:exhibit, user_id: user.id) }

    context "valid with parameter" do
      it "responds successfully" do
        post api_v1_multi_exhibits_url, params: { multi_exhibit: FactoryBot.attributes_for(:multi_exhibit, exhibit_id: exhibit.id) },
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json["lang"]).to eq "ja"
        expect(json["name"]).to eq "明治神宮"
        expect(json["description"]).to eq "明治神宮は大正3年に"
      end

      it "adds a multi exhibit" do
        expect{
          post api_v1_multi_exhibits_url, params: { multi_exhibit: FactoryBot.attributes_for(:multi_exhibit, exhibit_id: exhibit.id) },
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        }.to change(MultiExhibit, :count).by(1)
      end
    end

    context "invalid with parameter" do
      it "responds 422 error" do
        post api_v1_multi_exhibits_url, params: { multi_exhibit: FactoryBot.attributes_for(:multi_exhibit, exhibit_id: exhibit.id, name: "") },
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        expect(response).to have_http_status "422"
      end
    end
  end

  describe "PATCH /api/v1/multi_exhibits/id" do
    let(:user) { FactoryBot.create(:user) }
    let(:exhibit) { FactoryBot.create(:exhibit, user_id: user.id) }
    let(:multi_exhibit) { FactoryBot.create(:multi_exhibit, exhibit_id: exhibit.id) }

    context "as authorized uesr" do
      it "responds successfully" do
        patch api_v1_multi_exhibit_url(multi_exhibit.id),
              params: { multi_exhibit: FactoryBot.attributes_for(:multi_exhibit, exhibit_id: exhibit.id, name: "皇居") },
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        expect(response).to have_http_status(:success)
        json = JSON.parse(response.body)
        expect(json["lang"]).to eq "ja"
        expect(json["name"]).to eq "皇居"
        expect(json["description"]).to eq "明治神宮は大正3年に"
      end

      it "responds 422 error" do
        patch api_v1_multi_exhibit_url(multi_exhibit.id),
              params: { multi_exhibit: FactoryBot.attributes_for(:multi_exhibit, exhibit_id: exhibit.id, name: "") },
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        expect(response).to have_http_status "422"
      end
    end

    context "as unauthorized user" do
      it "responds 403 error" do
        patch api_v1_multi_exhibit_url(multi_exhibit.id),
              params: { multi_exhibit: FactoryBot.attributes_for(:multi_exhibit, exhibit_id: exhibit.id, name: "皇居") }
        expect(response).to have_http_status "403"
      end
    end
  end

  describe "DELETE /api/v1/multi_exhibits" do
    let(:user) { FactoryBot.create(:user) }
    let(:exhibit) { FactoryBot.create(:exhibit, user_id: user.id) }
    let(:multi_exhibit) { FactoryBot.create(:multi_exhibit, exhibit_id: exhibit.id) }

    context "as authorized uesr" do
      it "responds successfully" do
        delete api_v1_multi_exhibit_url(multi_exhibit.id),
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        expect(response).to have_http_status(:no_content)
      end

      it "delete a multi exhibit" do
        multi_exhibit2 = FactoryBot.create(:multi_exhibit2, exhibit_id: exhibit.id)
        expect{
          delete api_v1_multi_exhibit_url(multi_exhibit2.id),
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        }.to change(MultiExhibit, :count).by(-1)
      end
    end

    context "as unauthorized user" do
      it "responds 403 error" do
        delete api_v1_multi_exhibit_url(multi_exhibit.id)
        expect(response).to have_http_status "403"
      end
    end
  end
end
