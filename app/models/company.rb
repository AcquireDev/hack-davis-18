class Company < ApplicationRecord
  has_many :listings, dependent: :destroy
end
