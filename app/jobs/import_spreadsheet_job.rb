require 'csv'
require 'open-uri'

class ImportSpreadsheetJob
  include SuckerPunch::Job

  # perform
  # =======
  def perform(url)
    ActiveRecord::Base.connection_pool.with_connection do
      csv_text = open(url)
      csv = CSV.parse(csv_text, headers: ['company_name', 'job_title', 'url'])
      csv.each_with_index do |row,index|
        next if index == 0
        createListing(row.to_hash)
      end
    end
  end


  def createListing(listing_params)
    # puts listing_params
    if listing_params.has_key?("company_name")
      c_name = listing_params["company_name"]
      company = Company.find_or_create_by(name: c_name)
      @listing = Listing.new({
        company_id: company.id,
        description: listing_params[:description],
        deadline: listing_params[:deadline],
        job_title: listing_params["job_title"],
        url: listing_params["url"]
      })
    else
      @listing = Listing.new({
        description: listing_params[:description],
        deadline: listing_params[:deadline],
        job_title: listing_params["job_title"],
        url: listing_params["url"]
      })
    end
    if(@listing.save)
      ReconcileListingJob.new.perform(@listing)
    end
  end
end
