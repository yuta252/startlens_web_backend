class UserStatistic < ApplicationRecord
  validates :user_id, presence: true
  validates :tourist_id, presence: true
  validate :can_not_duplicated_date?

  belongs_to :tourist
  belongs_to :user

  scope :with_toursit, -> { joins(:tourist) }
  scope :count_by_hour, -> { group("HOUR(CONVERT_TZ(user_statistics.created_at, '+00:00', '+09:00'))").order("HOUR(CONVERT_TZ(user_statistics.created_at, '+00:00', '+09:00'))").count }
  scope :count_by_date, -> { group("DATE(CONVERT_TZ(user_statistics.created_at, '+00:00', '+09:00'))").order("DATE(CONVERT_TZ(user_statistics.created_at, '+00:00', '+09:00'))").count }
  scope :count_by_sex, -> { group("tourists.sex").order("count(tourists.sex) desc").count }
  scope :count_by_birth, -> { group("tourists.birth").order("tourists.birth").count }
  scope :count_by_country, -> { group("tourists.country").order("count(tourists.country) desc").count }

  def can_not_duplicated_date?
    if UserStatistic.exists?(user_id: user_id, tourist_id: tourist_id, created_at: Time.zone.now.all_day)
      errors.add(:created_at, '登録日が重複しています')
    end
  end

  def self.get_statistics(user_id, params={})
    now = Time.current
    user_statistics = User.find(user_id).user_statistics
    case params[:duration].to_i
    when 1
      statistic = user_statistics.where(created_at: now.all_day).with_toursit
      { visitors: statistic.count_by_hour, sex: statistic.count_by_sex, birth: statistic.count_by_birth, country: statistic.count_by_country }
    when 2
      statistic = user_statistics.where(created_at: 1.week.ago.beginning_of_day..now.end_of_day).with_toursit
      { visitors: statistic.count_by_date, sex: statistic.count_by_sex, birth: statistic.count_by_birth, country: statistic.count_by_country }
    when 3
      statistic = user_statistics.where(created_at: 1.month.ago.beginning_of_day..now.end_of_day).with_toursit
      { visitors: statistic.count_by_date, sex: statistic.count_by_sex, birth: statistic.count_by_birth, country: statistic.count_by_country }
    when 4
      statistic = user_statistics.where(created_at: 1.year.ago.beginning_of_day..now.end_of_day).with_toursit
      { visitors: statistic.count_by_date, sex: statistic.count_by_sex, birth: statistic.count_by_birth, country: statistic.count_by_country }
    else
      statistic = user_statistics.where(created_at: 1.week.ago.beginning_of_day..now.end_of_day).with_toursit
      { visitors: statistic.count_by_date, sex: statistic.count_by_sex, birth: statistic.count_by_birth, country: statistic.count_by_country }
    end
  end
end
