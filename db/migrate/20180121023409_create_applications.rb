class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.belongs_to :listing, foreign_key: true, index: true
      t.boolean :applied, index: true
      t.string :status
      t.string :notes
      t.belongs_to :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
