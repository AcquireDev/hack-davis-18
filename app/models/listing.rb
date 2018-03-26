class Listing < ApplicationRecord
  belongs_to :company, optional: true
  belongs_to :job_board
  has_many :applications, dependent: :destroy

  def self.create_listing(job_board_id, job_title, description, deadline, company_name, url)
    # Check for duplicates
    company = Company.find_by_name(company_name)
    if company
      prev_listing = Listing.where('job_title = ? AND company_id = ?', job_title, company.id )
    else
      prev_listing = Listing.where('job_title = ? AND company_id = ?', job_title, nil )
    end
    return nil if prev_listing.first

    company = Company.find_or_create_by(name: company_name)
    listing = Listing.new({
      job_board_id: job_board_id,
      company_id: company.id,
      description: description,
      deadline: deadline,
      job_title: job_title,
      url: url
    })

    if listing.save
      return listing
    else
      return nil
    end
  end
end
