class Api::V1::Tourist::FavoritesController < ApplicationController
  before_action :check_login_tourist, only: [:index, :create, :destroy]
  before_action :set_favorite, only: [:destroy]
  before_action :check_owner, only: [:destroy]
  before_action :snakeize_params, only: [:create, :destroy]

  def index
    spots = User.get_favorite(current_tourist.id)
    render json: spots, each_serializer: SpotSerializer, scope: { tourist_id: current_tourist&.id }, include: '**'
  end

  def create
    favorite = current_tourist.favorites.build(favorite_params)
    if favorite.save
      favorite_serializer = parse_json(favorite)
      render json: favorite_serializer, status: :created
    else
      logger.debug("Favorite model isn't created: #{favorite.errors.messages}")
      render json: { errors: favorite.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite.destroy
    render json: {}, status: :no_content
  end

  private

  def favorite_params
    params.require(:favorite).permit(:user_id)
  end

  def set_favorite
    @favorite = Favorite.find_by(user_id: params[:id], tourist_id: current_tourist.id)
  end

  def check_owner
    head :forbidden unless @favorite.tourist_id == current_tourist&.id
  end
end
