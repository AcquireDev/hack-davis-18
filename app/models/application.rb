class Application < ApplicationRecord
  belongs_to :listing
  belongs_to :user
  has_one :job_board, through: :listing
  has_one :company, through: :listing
  after_update :remove_new

  scope :ordered, -> {
   joins(:company).order("companies.name")
 }

  enum stage: {not_applied: 0, applied: 1, hidden: 2, interviewing: 3, rejected: 4, offer: 5, accepted: 6}

  def remove_new
    if self.status == "new"
      self.update_attributes(status: "")
    end
  end
end
