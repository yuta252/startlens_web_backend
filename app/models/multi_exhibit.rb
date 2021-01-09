class MultiExhibit < ApplicationRecord
  belongs_to :exhibit

  validates :exhibit_id, presence: true
  validates :lang, presence: true, inclusion: { in: %w(ja en zh-CN zh-TW ko), message: "正しい%{attribute}を選択してください。" }
  validates :name, presence: { message: "%{attribute}を入力してください。" },
            length: { maximum: 255, message: "%{attribute}は255文字以下で入力してください。"}
  validates :description, presence: { message: "%{attribute}を入力してください。"}
end
