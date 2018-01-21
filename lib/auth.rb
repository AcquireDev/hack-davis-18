require 'jwt'

class Auth
  ALGORITHM = 'HS256'
  AUTH_SECRET = Rails.application.secrets.secret_key_base

  # issue
  # =====
  #   Wrapper for JWT.encode
  #
  # Params:
  #   payload - The payload for the token
  def self.issue(payload)
    JWT.encode(
      payload,
      AUTH_SECRET,
      ALGORITHM
    )
  end

  # decode
  # ======
  #   Wrapper for JWT.decode
  #
  # Params:
  #   token - The token to decode
  def self.decode(token)
    JWT.decode(
      token,
      AUTH_SECRET,
      true,
      { algorithm: ALGORITHM }
    ).first
  end

end
