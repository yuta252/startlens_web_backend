class Api::V1::MultiProfilesController < ApplicationController
  before_action :check_login, only: [:index, :create, :update, :destroy]
  before_action :set_multi_profile, only: [:update, :destroy]
  before_action :check_owner, only: [:update, :destroy]

  def index
    multi_profile = current_user.multi_profiles
    multi_profile_serializer = parse_json(multi_profile)
    render json: multi_profile_serializer, status: :ok
  end

  def create
    multi_profile = current_user.multi_profiles.build(multi_profile_params)
    if multi_profile.save
      multi_profile_serializer = parse_json(multi_profile)
      render json: multi_profile_serializer, status: :created
    else
      render json: { errors: multi_profile.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @multi_profile.update(multi_profile_params)
      multi_profile_serializer = parse_json(@multi_profile)
      render json: multi_profile_serializer, status: :ok
    else
      render json: { errors: @multi_profile.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @multi_profile.destroy
    render json: {}, status: :no_content
  end

  private

  def multi_profile_params
    params.require(:multi_profile).permit(:lang, :username, :self_intro, :address_prefecture, :address_city, :address_street, :entrance_fee, :business_hours, :holiday, :translated)
  end

  def set_multi_profile
    @multi_profile = MultiProfile.find(params[:id])
  end

  def check_owner
    head :forbidden unless @multi_profile&.user_id == current_user&.id
  end
end
