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
    if params[:profile][:image_file]
      logger.debug("PramsThumbnail: #{params[:profile][:telephone]}")
      if @profile.update_attribute(:image_file, params[:profile][:image_file])
        profile_serializer = parse_json(@profile)
        render json: profile_serializer, status: :ok
      else
        logger.debug("Thumbnail can't be updated: #{@profile.errors.messages}")
        logger.debug("#{params[:profile][:conpany_site]}")
        logger.debug("#{params[:profile][:telephone]}")
        render json: { errors: @profile.errors }, status: :unprocessable_entity
      end
    else
      if @profile.update(profile_params)
        profile_serializer = parse_json(@profile)
        render json: profile_serializer, status: :ok
      else
        logger.debug("Profile model isn't updated: #{@profile.errors.messages}")
        render json: { errors: @profile.errors }, status: :unprocessable_entity
      end
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:major_category, :telephone, :company_site, :image_file, :latitude, :longitude)
  end

  def check_owner
    head :forbidden unless @profile&.user_id == current_user&.id
  end

  def set_profile
    @profile = current_user.profile
  end
end
