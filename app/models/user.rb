class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # TODO: 国際化ドメイン対応
  validates :email, presence: { message: "%{attribute}を入力してください。" },
            length: { maximum: 255, message: "%{attribute}は255文字以下で入力してください。" },
            format: { with: VALID_EMAIL_REGEX, message: "正しいフォーマットを入力してください。" },
            uniqueness: { message: "この%{attribute}はすでに登録されています。" }

  has_secure_password
  validates :password, presence: { message: "パスワードを入力してください" },
            length: { minimum: 6, message: "%{attribute}は6文字以上で入力してください。" },
            allow_nil: true

  has_one :profile, dependent: :destroy
  has_many :multi_profiles, dependent: :destroy
end
