# Create applications for all of the listings
class AddApplicationsJob
  include SuckerPunch::Job

  # perform
  # =======
  def perform(user_id)
    ActiveRecord::Base.connection_pool.with_connection do
      # Skip on tests
      if Rails.env.test?
        return
      end

      user = User.find_by_id(user_id)

      # Get full list of all current listings by the user
      current_listings = Hash.new

      user.applications.each do |app|
        current_listings[app.listing_id] = true
      end

      return unless user
      Listing.find_in_batches do |batch|
        batch.each do |listing|
          next if(current_listings[listing.id])
          app = Application.new(listing_id: listing.id, applied: false, status: "new", notes: "", user_id: user.id)
          app.save
        end
      end
    end
  end
end
