class Api::V1::Tourist::UserStatisticsController < ApplicationController
  before_action :check_login_tourist, only: [:create]

  def create
    user_statistic = current_tourist.user_statistics.build(user_statistic_params)
    if user_statistic.save
      render json: { is_errors: true, message: "登録に成功しました" }, status: :ok
    else
      render json: { is_errors: false, message: "登録に失敗しました" }, status: :ok
    end
  end

  private

  def user_statistic_params
    params.require(:user_statistic).permit(:user_id)
  end
end
