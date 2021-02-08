class Api::V1::TestsController < ApplicationController
  def index
    render json: { message: "success" }, status: :ok
  end
end
