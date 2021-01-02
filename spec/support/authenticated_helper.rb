module AuthenticationHelper
  def authenticate_stub(user)
    # define instance variable
    @current_user = [
      {
        'email' => 'sample1@gmail.com',

      }
    ]
  end
end