require "slack-notifier"

class NewUserJob
  include SuckerPunch::Job

  # perform
  # =======
  def perform(user)
    ActiveRecord::Base.connection_pool.with_connection do
      # Skip on tests
      if Rails.env.test?
        return
      end

      notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"]
      notifier.ping "New user: #{user.email}"
    end
  end
end
