class Api::V1::Tourist::SpotsController < ApplicationController
  include SpotPaginable

  def index
    spots = User.all.page(current_page).per(per_page).search(params)

    options = {
      params: {
        last: spots.total_pages,
        page: current_page,
        count: params[:items] ? params[:items] : 0,
        query: params[:query] ? params[:query] : "",
        category: params[:category] ? params[:category] : 0,
        prefecture: params[:prefecture] ? params[:prefecture] : ""
      }
    }
    render json: spots, root: "data", each_serializer: SpotSerializer, meta: options, adapter: :json
  end
end
