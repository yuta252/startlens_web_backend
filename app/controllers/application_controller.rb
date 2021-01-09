class ApplicationController < ActionController::API
  # Include authorization JWT token in controller
  include Authenticable
  include SerializableResource

  protected

  def snakeize_params
    params.deep_snakeize!
  end
end
