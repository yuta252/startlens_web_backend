class MultiProfile < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  # TODO: 他言語対応
  validates :lang, presence: true, inclusion: { in: %w(ja en zh-CN zh-TW ko), message: "正しい%{attribute}を選択してください。" }
  validates :username, presence: { message: "%{attribute}を入力してください。" },
            length: { maximum: 255, message: "%{attribute}は255文字以下で入力してください。"}
  validates :self_intro, presence: { message: "%{attribute}を入力してください。"}
  validates :translated, presence: { message: "%{attribute}を入力してください。"},
            numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1, message: "%{attribute}は0, 1のどちらかを選択してください。" },
            allow_nil: true
end
