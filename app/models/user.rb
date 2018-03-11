class User < ApplicationRecord
  has_secure_password # User authentication
  after_create :load_applications

  validates :email, uniqueness: true

  has_many :applications, dependent: :destroy

  def load_applications
    AddApplicationsJob.perform_async(self.id)
  end
end
