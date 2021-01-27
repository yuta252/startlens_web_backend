module Authenticable
  def current_user
    return @current_user if @current_user

    header = request.headers['Authorization']
    return nil if header.nil?
    return nil if header == "undefined"

    decoded = JsonWebToken.decode(header)
    @current_user = User.find(decoded[:user_id]) rescue ActiveRecord::RecordNotFound
  end

  def current_tourist
    return @current_tourist if @current_tourist

    header = request.headers['Authorization']
    return nil if header.nil?
    logger.debug("header: #{header}")
    return nil if header == "undefined"

    decoded = JsonWebToken.decode(header)
    @current_tourist = Tourist.find(decoded[:tourist_id]) rescue ActiveRecord::RecordNotFound
  end

  protected

  def check_login
    head :forbidden unless self.current_user
  end

  def check_login_tourist
    head :forbidden unless self.current_tourist
  end
end