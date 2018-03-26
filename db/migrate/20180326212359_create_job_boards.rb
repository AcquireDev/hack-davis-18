class CreateJobBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :job_boards do |t|
      t.string :location
      t.string :job_type
      t.string :position_type

      t.timestamps
    end

    add_column :listings, :job_board_id, :integer, index: true, foreign_key: true
  end
end
