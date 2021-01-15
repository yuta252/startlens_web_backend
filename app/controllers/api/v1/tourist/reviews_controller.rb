class Api::V1::Tourist::ReviewsController < ApplicationController
  before_action :check_login_tourist, only: [:create, :destroy]
  before_action :set_tourist, only: [:destroy]
  before_action :check_owner, only: [:destroy]
  before_action :snakeize_params, only: [:create, :destroy]

  def create
    review = current_tourist.reviews.build(review_params)
    if review.save
      review_serializer = parse_json(review)
      render json: review_serializer, status: :created
    else
      logger.debug("Review model isn't created: #{review.errors.messages}")
      render json: { errors: review.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    render json: {}, status: :no_content
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :lang, :post_review, :rating)
  end

  def set_tourist
    @review = Review.find(params[:id])
  end

  def check_owner
    head :forbidden unless @review.tourist_id == current_tourist&.id
  end
end
