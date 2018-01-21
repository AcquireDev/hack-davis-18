class BaseController < ApplicationController
  before_action :authenticate_user

  # authenticated?
  # ==============
  #   Is the request authenticated (does the user have access)
  # Returns:
  #   Boolean
  def authenticated?
    !!authorized_user
  end

  # authorized_user
  # ===============
  #   The user allowed access
  def authorized_user
    if auth_present?
      user_id = auth["user"]
      if @authorized_user && @authorized_user.id == user_id
        return @authorized_user
      else
        @authorized_user ||= User.find_by_id(user_id)
      end
    else
    end
  end

  # authenticate_user
  # =================
  #   Check incoming request for the following authorization:
  # => "HTTP_AUTHORIZATION" => "Bearer <super encoded JWT>"
  # Renders:
  # 401 (Unauthorized) on failure to authenticate
  def authenticate_user
    render json: { error: "Unauthorized." }, status: 401 unless authenticated?
  end

  private

  # token
  # =====
  #   The JWT from the request header
  def token
    request.env["HTTP_AUTHORIZATION"].scan(/Bearer(.*)$/).flatten.last.tr(" ", "")
  end

  # auth
  # ====
  #   The decoded token -> the auth hash.
  def auth
    Auth.decode(token)
  end

  # auth_present?
  # =============
  #   Is the authorization header supplied?
  def auth_present?
    request.env.fetch("HTTP_AUTHORIZATION", "") && !!request.env.fetch("HTTP_AUTHORIZATION", "").scan(/Bearer/).flatten.first
  end
end
