class Api::V1::Tourist::SpotsController < ApplicationController
  include SpotPaginable

  def index
    spots = User.all.page(current_page).per(per_page).search(params)

    options = {
      params: {
        last: spots.total_pages,
        page: current_page,
        count: params[:items] ? params[:items] : "",
        query: params[:query] ? params[:query] : "",
        category: params[:category] ? params[:category] : "",
        prefecture: params[:prefecture] ? params[:prefecture] : ""
      }
    }
    render json: spots, root: "data", each_serializer: SpotSerializer, scope: { tourist_id: current_tourist&.id }, meta: options, include: '**', adapter: :json
  end

  def show
    spot = User.find(params[:id])
    exhibits = spot.exhibits
    exhibit_serializer = parse_json(exhibits)
    render json: exhibit_serializer, status: :ok
  end
end
