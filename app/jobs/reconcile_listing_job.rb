# Create applications for all of the listings
class ReconcileListingJob
  include SuckerPunch::Job

  # perform
  # =======
  def perform(listing)
    ActiveRecord::Base.connection_pool.with_connection do
      # Skip on tests
      if Rails.env.test?
        return
      end

      User.find_in_batches do |batch|
        batch.each do |user|
          app = Application.new(listing_id: listing.id, applied: false, status: "new", notes: "", user_id: user.id)
          app.save
        end
      end
    end
  end
end
