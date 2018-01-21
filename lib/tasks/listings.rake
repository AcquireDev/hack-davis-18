namespace :listings do
  desc "Search CareerJet for new listings"
  task scrape: :environment do
    if Rails.env.development?
      log = ActiveSupport::Logger.new(STDOUT)
    else
      log = ActiveSupport::Logger.new('log/listing_scrape.log')
    end

    start_time = Time.now

    log.info "Scraping for job listings"
    log.info "=================================="
    log.info "TIME: #{start_time}"
    log.info ""


    cj_api_client = Careerjet::APIClient.new(:locale=> :en_US)

    # locations = ['San Francisco', 'Mountain View', 'Palo Alto',
    #    'San Jose', 'Sunnyvale', 'Redwood City', 'Menlo Park',
    #    'Cupertino', 'Santa Clara', 'Fremont', 'San Mateo']

   locations = ['San Mateo']

   locations.each do |location|
     log.info ""
     log.info "Searching in: #{location}"
     page = 1
     max_page = 1
    while(page <= max_page)
      results = cj_api_client.search(
        :keywords   => 'title:software intern',
        :location   => location,
        :affid      => "cef2d517380b3e9060386533f9e28bfd",
        :user_ip    => 'HIDDEN',
        :user_agent => 'HIDDEN',
        :page       => page,
        :url        => 'http://HIDDEN.com'
      )

      max_page = results.pages
      log.info "Processing Page #{page} of #{max_page}"

      unless results.jobs
        log.info "ERROR: No jobs or location error."
        break
      end

      results.jobs.each do |job|
        final_url = RedirectFollow.get_url(job.url)
        # log.info "Finalized URL: #{final_url}"
        listing = Listing.create_listing(job.title, job.description, nil, job.company, final_url)
        log.info "Adding: #{listing.job_title}" if listing
      end

      page += 1
    end
  end

    # Run a job to create applications for all of the users
    User.find_in_batches do |batch|
      batch.each do |user|
        AddApplicationsJob.perform_async(user.id)
      end
    end
  end
end
