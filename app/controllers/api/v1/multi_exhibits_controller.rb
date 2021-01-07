class Api::V1::MultiExhibitsController < ApplicationController
  before_action :check_login, only: [:create, :update, :destroy]
  before_action :set_multi_exhibit, only: [:update, :destroy]
  before_action :check_owner, only: [:update, :destroy]
  before_action :snakeize_params, only: [:create, :update]

  def create
    exhibit = Exhibit.find(params[:multi_exhibit][:exhibit_id])
    multi_exhibit = exhibit.multi_exhibits.build(multi_exhibit_params)
    if multi_exhibit.save
      multi_exhibit_serializer = parse_json(multi_exhibit)
      render json: multi_exhibit_serializer, status: :created
    else
      render json: { errors: multi_exhibit.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @multi_exhibit.update(multi_exhibit_params)
      multi_exhibit_serializer = parse_json(@multi_exhibit)
      render json: multi_exhibit_serializer, status: :ok
    else
      render json: { errors: @multi_exhibit.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @multi_exhibit.destroy
    render json: {}, status: :no_content
  end

  private

  def multi_exhibit_params
    params.require(:multi_exhibit).permit(:id, :exhibit_id, :lang, :name, :description)
  end

  def set_multi_exhibit
    @multi_exhibit = MultiExhibit.find(params[:id])
  end

  def check_owner
    head :forbidden unless @multi_exhibit&.exhibit.user_id == current_user&.id
  end
end
