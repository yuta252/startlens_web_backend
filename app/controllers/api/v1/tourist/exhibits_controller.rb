class Api::V1::Tourist::ExhibitsController < ApplicationController
  def show
    spot = User.find(params[:id])
    exhibits = spot.exhibits
    exhibit_serializer = parse_json(exhibits)
    render json: exhibit_serializer, status: :ok
  end
end
