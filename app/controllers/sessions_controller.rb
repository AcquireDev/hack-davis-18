class SessionsController < BaseController
  skip_before_action :authenticate_user, only: [:create]

  # create
  # ======
  #   Create a new API session
  # Renders:
  #   A valid JWT given an authenicated user or a 404 error otherwise.
  # POST /authenticate
  def create
    unless auth_params.has_key?(:email)
      render json: {error: "No email supplied.", status: 404}, status: 404
      return
    end
    user = User.find_by(email: auth_params[:email])

    unless user
      render json: {error: "User not found with supplied email.", status: 404}, status: 404
      return
    end

    if user && user.authenticate(auth_params[:password])
      jwt = Auth.issue(user: user.id)
      render json: {jwt: jwt}, status: :ok
      return
    else
      render json: {error:  "User does not exist with these credentials.",
                    status: 404}, status: 404
      return
    end
  end

  private

  # auth_params
  # ===========
  #   Valid paramaters
  def auth_params
    params.permit(:email, :password)
  end
end
