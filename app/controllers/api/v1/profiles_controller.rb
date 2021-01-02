class Api::V1::ProfilesController < ApplicationController
  before_action :check_login, only: [:show, :update]
  before_action :set_profile, only: [:show, :update]
  before_action :check_owner, only: [:update]
  before_action :snakeize_params, only: [:update]

  def show
    profile_serializer = parse_json(@profile)
    render json: profile_serializer, status: :ok
  end

  def update
    if @profile.update(profile_params)
      profile_serializer = parse_json(@profile)
      render json: profile_serializer, status: :ok
    else
      render json: { errors: @profile.errors }, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:major_category, :telephone, :company_site, :image_file)
  end

  def check_owner
    head :forbidden unless @profile&.user_id == current_user&.id
  end

  def set_profile
    @profile = current_user.profile
  end
end
