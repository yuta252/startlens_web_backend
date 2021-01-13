class Api::V1::Tourist::TouristsController < ApplicationController
  before_action :check_login_tourist, only: [:update]
  before_action :set_tourist, only: [:update]
  before_action :check_owner, only: [:update]
  before_action :snakeize_params, only: [:update]

  def create
    tourist = Tourist.new(tourist_params)
    tourist.username = "Anonymous"
    tourist.sex = 0
    tourist.birth = 0
    tourist.country = "na"
    tourist.lang = "na"
    if tourist.save
      tourist_serializer = parse_json(tourist)
      render json: tourist_serializer, status: :created
    else
      logger.debug("Tourist model isn't created: #{tourist.errors.messages}")
      render json: { errors: tourist.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @tourist.update(tourist_params)
      tourist_serializer = parse_json(@tourist)
      render json: tourist_serializer, status: :ok
    else
      logger.debug("Tourist model isn't updated: #{@tourist.errors.messages}")
      render json: { errors: @tourist.errors }, status: :unprocessable_entity
    end
  end

  private

  def tourist_params
    params.require(:tourist).permit(:email, :password, :username, :sex, :birth, :country, :lang, :image_file)
  end

  def set_tourist
    @tourist = Tourist.find(params[:id])
  end

  def check_owner
    head :forbidden unless @tourist.id == current_tourist&.id
  end
end
