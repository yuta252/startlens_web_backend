class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]
  before_action :check_owner, only: [:update, :destroy]

  def load
    if current_user.nil?
      render json: { errors: { "user": ["再ログインしてください。"] } }
    end
    user_serializer = parse_json(current_user)
    render json: user_serializer, status: :ok
  end

  def create
    @user = User.new(user_params)
    # User model and Profile related to user need to be registered at the same time
    begin
      ActiveRecord::Base.transaction do
        if @user.save
          # Continue to create user profile when user account is created
          @profile = Profile.new
          @profile.user_id = @user.id
          if @profile.save
            user_serializer = parse_json(@user)
            render json: user_serializer, status: :created
          else
            raise ActiveRecord::RecordInvalid
          end
        else
          render json: { errors: @user.errors }, status: :unprocessable_entity
        end
      end
    rescue => exception
      logger.debug("Profile model isn't created although user model is created: #{exception}")
      render json: { errors: @profile.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      user_serializer = parse_json(@user)
      render json: user_serializer, status: :ok
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_owner
    head :forbidden unless @user.id == current_user&.id
  end
end
