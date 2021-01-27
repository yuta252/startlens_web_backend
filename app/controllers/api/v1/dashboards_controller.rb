class Api::V1::DashboardsController < ApplicationController
  before_action :check_login_tourist, only: [:index]

  def index
    # parameter
    # duration
    # 1: 今日, 2: 1週間, 3: 1ヶ月, 4: 1年
    statistic = UserStatistic.get_statistics(current_user.id, params)
    render json: statistic, status: :ok
  end
end
