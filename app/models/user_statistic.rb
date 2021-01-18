class UserStatistic < ApplicationRecord
  validates :user_id, presence: true
  validates :tourist_id, presence: true
  validate :can_not_duplicated_date?

  belongs_to :tourist
  belongs_to :user

  def can_not_duplicated_date?
    if UserStatistic.exists?(user_id: user_id, tourist_id: tourist_id, created_at: Time.zone.now.all_day)
      errors.add(:created_at, '登録日が重複しています')
    end
  end
end
