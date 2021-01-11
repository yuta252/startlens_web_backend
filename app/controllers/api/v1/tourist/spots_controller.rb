class Api::V1::Tourist::SpotsController < ApplicationController
  include SpotPaginable

  def index
    spots = User.all.page(current_page).per(per_page).search(params)

    options = {
      params: {
        last: spots.total_pages,
        count: params[:items],
        query: params[:query],
        category: params[:category],
        prefecture: params[:prefecture]
      }
    }
    render json: spots, root: "data", each_serializer: SpotSerializer, meta: options, adapter: :json
  end
end
