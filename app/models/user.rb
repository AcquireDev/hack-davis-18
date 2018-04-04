class User < ApplicationRecord
  has_secure_password # User authentication
  after_commit :load_applications, on: :create

  validates :email, uniqueness: true

  has_many :applications, dependent: :destroy

  has_settings do |s|
    s.key :job_search, :defaults => { :job_board_id => 0}
  end

  def load_applications
    AddApplicationsJob.perform_async(self.id)
  end
end
