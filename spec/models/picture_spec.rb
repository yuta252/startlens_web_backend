require 'rails_helper'

RSpec.describe Picture, type: :model do
  describe "has instance method" do
    let(:user) { FactoryBot.create(:user) }
    let(:exhibit) { FactoryBot.create(:exhibit, user_id: user.id)}

    it "self.createpictures returns true" do
      encoded_image = encode("sample_test.png")
      encoded_image2 = encode("sample_test2.png")
      picture_params = {image_file: [encoded_image, encoded_image2]}
      picture = Picture.create_pictures(exhibit.id, picture_params)
      expect(picture).to eq true
    end
  end
end
