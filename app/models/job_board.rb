class JobBoard < ApplicationRecord
  has_many :listings, dependent: :destroy
  # has_and_belongs_to_many :users
end
