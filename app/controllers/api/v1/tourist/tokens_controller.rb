class Api::V1::Tourist::TokensController < ApplicationController
  def create
    @tourist = Tourist.find_by_email(tourist_params[:email])
    if @tourist&.authenticate(tourist_params[:password])
      render json: {token: JsonWebToken.encode(tourist_id: @tourist.id), email: @tourist.email}, status: :ok
    else
      render json: {}, status: :unauthorized
    end
  end

  private

  def tourist_params
    params.require(:tourist).permit(:email, :password)
  end
end
