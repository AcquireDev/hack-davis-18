class User < ApplicationRecord
  has_secure_password # User authentication

  validates :email, uniqueness: true
end
