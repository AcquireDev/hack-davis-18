class Listing < ApplicationRecord
  belongs_to :company, optional: true
end
