module SpotPaginable
  protected

  def current_page
    (params[:page] || 1).to_i
  end

  def per_page
    (params[:per_page] || 12).to_i
  end
end