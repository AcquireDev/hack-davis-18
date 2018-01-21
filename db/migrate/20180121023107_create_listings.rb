class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :job_title
      t.string :description
      t.date :deadline
      t.belongs_to :company, foreign_key: true, index: true

      t.timestamps
    end
  end
end
