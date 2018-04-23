require "slack-notifier"

class FlagListingAsClosedJob
  include SuckerPunch::Job

  # perform
  # =======
  def perform(user, listing)
    ActiveRecord::Base.connection_pool.with_connection do
      listing.update_attributes(closed: true)

      listing.applications.each do |app| 
        if(!app.applied)
          app.update_attributes(stage: "hidden")
        end
      end
      
      # Send notification
      notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"]
      notifier.ping "User (#{user.email}) marked #{listing.company.name} - #{listing.job_title} as closed."
    end
  end
end
