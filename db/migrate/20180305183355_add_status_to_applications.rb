class AddStatusToApplications < ActiveRecord::Migration[5.0]
  def change
    # A little misleading but it's fine for the prototype: Stage - The user defined status of an application, Status - Is the application new?
    add_column :applications, :stage, :integer, default: 0, index: true
  end
end
