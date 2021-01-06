class Api::V1::ExhibitsController < ApplicationController
  before_action :check_login, only: [:index, :create, :update, :destroy]
  before_action :set_exhibit, only: [:update, :destroy]
  before_action :check_owner, only: [:update, :destroy]
  before_action :snakeize_params, only: [:create, :update]

  def index
    exhibit = current_user.exhibits
    exhibit_serializer = parse_json(exhibit)
    render json: exhibit_serializer, status: :ok
  end

  # At create action, save exhibit, picture, multi_exhibit (in this order) in a series of processing.
  # Implement transaction process below. If some model validation failed, rollback process and return error json serializer.
  def create
    exhibit = current_user.exhibits.build()
    begin
      if exhibit.save
        # save all picture at first and then save multiple language info.
        if Picture.create_pictures(exhibit.id, params[:exhibit])
          multi_exhibit = exhibit.multi_exhibits.build(lang: params[:exhibit][:lang], name: params[:exhibit][:name], description: params[:exhibit][:description])
          if multi_exhibit.save
            exhibit_serializer = parse_json(exhibit)
            render json: exhibit_serializer, status: :created
          else
            logger.debug("failed to save multi language exhibit info")
            raise ActiveRecord::RecordInvalid
          end
        else
          logger.debug("failed to save all pictures")
          raise ActiveRecord::RecordInvalid
        end
      else
        logger.debug("failed to create exhibit: #{exception}")
        raise ActiveRecord::RecordInvalid
      end
    rescue => exception
      logger.debug("exhibit transaction failed: #{exception}")
      render json: { errors: exhibit.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @exhibit.destroy
    render json: {}, status: :no_content
  end

  private

  def exhibit_params
    params.require(:exhibit).permit(:lang, :name, :description, image_file: [])
  end

  def set_exhibit
    @exhibit = Exhibit.find(params[:id])
  end

  def check_owner
    head :forbidden unless @exhibit&.user_id == current_user&.id
  end
end
