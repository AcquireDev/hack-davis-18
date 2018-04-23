class AddClosedToListing < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :closed, :boolean, default: false
  end
end
