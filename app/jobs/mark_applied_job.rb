require "slack-notifier"

class MarkAppliedJob
  include SuckerPunch::Job

  # perform
  # =======
  def perform(application)
    ActiveRecord::Base.connection_pool.with_connection do
      # Skip on tests
      if Rails.env.test?
        return
      end
       
      notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"]
      notifier.ping "#{application.user.email} just applied to #{application.company.name} - #{application.listing.job_title}"
    end
  end
end
