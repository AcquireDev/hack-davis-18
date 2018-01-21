class Application < ApplicationRecord
  belongs_to :listing
  belongs_to :user
  after_update :remove_new

  def remove_new
    if self.status == "new"
      self.update_attributes(status: "")
    end
  end
end
