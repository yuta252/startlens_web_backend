class Api::V1::Tourist::ExhibitFavoritesController < ApplicationController
  before_action :check_login_tourist, only: [:create, :destroy]
  before_action :set_exhibit_favorite, only: [:destroy]
  before_action :check_owner, only: [:destroy]
  before_action :snakeize_params, only: [:create, :destroy]

  def create
    exhibit_favorite = current_tourist.exhibit_favorites.build(exhibit_favorite_params)
    if exhibit_favorite.save
      exhibit_favorite_serializer = parse_json(exhibit_favorite)
      render json: exhibit_favorite_serializer, status: :created
    else
      logger.debug("ExhibitFavorite model isn't created: #{exhibit_favorite.errors.messages}")
      render json: { errors: exhibit_favorite.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @exhibit_favorite.destroy
    render json: {}, status: :no_content
  end

  private

  def exhibit_favorite_params
    params.require(:exhibit_favorite).permit(:exhibit_id)
  end

  def set_exhibit_favorite
    @exhibit_favorite = ExhibitFavorite.find(params[:id])
  end

  def check_owner
    head :forbidden unless @exhibit_favorite.tourist_id == current_tourist&.id
  end
end
