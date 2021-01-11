require 'rails_helper'

RSpec.describe "Api::V1::Exhibits", type: :request do

  describe "GET /api/v1/exhibits" do
    before do
      @user = FactoryBot.create(:user)
      exhibit = FactoryBot.create(:exhibit, user_id: @user.id)
      exhibit2 = FactoryBot.create(:exhibit2, user_id: @user.id)
      multi_exhibit = FactoryBot.create(:multi_exhibit, exhibit_id: exhibit.id)
      multi_exhibit2 = FactoryBot.create(:multi_exhibit2, exhibit_id: exhibit2.id)
    end

    it "responds successfully" do
      get api_v1_exhibits_url, headers: { Authorization: JsonWebToken.encode(user_id: @user.id)}
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json.length).to eq 2
    end
  end

  describe "POST /api/v1/exhibits" do
    let(:user) { FactoryBot.create(:user) }
    let(:encoded_image) { encode("sample_test.png") }
    let(:encoded_image2) { encode("sample_test2.png") }

    context "valid with parameter" do
      it "responds successfully" do
        post api_v1_exhibits_url, params: { exhibit: {lang: "ja", name: "sample_name", description: "sample_description", image_file: [encoded_image, encoded_image2]} },
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)
        expect(json["pictures"].count).to eq 2
        expect(json["multiExhibits"].count).to eq 1
        expect(json["multiExhibits"][0]["lang"]).to eq "ja"
        expect(json["multiExhibits"][0]["name"]).to eq "sample_name"
        expect(json["multiExhibits"][0]["description"]).to eq "sample_description"
      end

      it "adds a exhibit, 2 pictures and a multi_exhibit" do
        expect{
          post api_v1_exhibits_url, params: { exhibit: {lang: "ja", name: "sample_name", description: "sample_description", image_file: [encoded_image, encoded_image2]} },
              headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        }.to change(Exhibit, :count).by(1).and change(Picture, :count).by(2).and change(MultiExhibit, :count).by(1)
      end
    end
  end

  describe "PATCH /api/v1/exhibits" do
    let(:user) { FactoryBot.create(:user) }
    let(:encoded_image) { encode("sample_test.png") }
    let(:encoded_image2) { encode("sample_test2.png") }

    context "valid with parameter" do
      it "responds successfully" do
        post api_v1_exhibits_url, params: { exhibit: {lang: "ja", name: "sample_name", description: "sample_description", image_file: [encoded_image, encoded_image2]} },
                headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        json = JSON.parse(response.body)
        exhibit_id = json["id"]
        expect{
          patch api_v1_exhibit_url(exhibit_id), params: { exhibit: { image_file: [encoded_image]} },
                headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
        }.to change(Picture, :count).by(-1)
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "DELETE /api/v1/exhibits" do
    before do
      @user = FactoryBot.create(:user)
      @exhibit = FactoryBot.create(:exhibit, user_id: @user.id)
      @multi_exhibit = FactoryBot.create(:multi_exhibit, exhibit_id: @exhibit.id)
    end

    context "as authorized user" do
      it "responds successfully " do
        delete api_v1_exhibit_url(@exhibit.id),
              headers: { Authorization: JsonWebToken.encode(user_id: @user.id)}
        expect(response).to have_http_status :no_content
      end

      it "delete a multi exhibit" do
        expect{
          delete api_v1_exhibit_url(@exhibit.id),
              headers: { Authorization: JsonWebToken.encode(user_id: @user.id)}
        }.to change(Exhibit, :count).by(-1).and change(MultiExhibit, :count).by(-1)
      end
    end

    context "as unautorized user" do
      it "responds 403 error" do
        delete api_v1_exhibit_url(@exhibit.id)
        expect(response).to have_http_status "403"
      end
    end
  end
end
