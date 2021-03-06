class Api::V1::Tourist::TouristsController < ApplicationController
  before_action :check_login_tourist, only: [:update]
  before_action :set_tourist, only: [:update]
  before_action :check_owner, only: [:update]
  before_action :snakeize_params, only: [:create, :update]

  def load
    if current_tourist.nil?
      render json: { id: 0, email: "", username: "", thumbnail_url: "", sex: 0, birth: 0, country: "", lang: "" }, status: :ok
    else
      tourist_serializer = parse_json(current_tourist)
      render json: tourist_serializer, status: :ok
    end
  end

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
    if params[:tourist][:image_file]
      if @tourist.update_attribute(:image_file, params[:tourist][:image_file])
        tourist_serializer = parse_json(@tourist)
        render json: tourist_serializer, status: :ok
      else
        logger.debug("Tourist model isn't updated: #{@tourist.errors.messages}")
        render json: { errors: @tourist.errors }, status: :unprocessable_entity
      end
    else
      if @tourist.update(tourist_params)
        tourist_serializer = parse_json(@tourist)
        render json: tourist_serializer, status: :ok
      else
        logger.debug("Tourist model isn't updated: #{@tourist.errors.messages}")
        render json: { errors: @tourist.errors }, status: :unprocessable_entity
      end
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
