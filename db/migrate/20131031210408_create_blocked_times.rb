class CreateBlockedTimes < ActiveRecord::Migration
  def change
    create_table :blocked_times do |t|
      t.references :user
      t.references :page
      t.datetime :start_time
      t.text :reason
      t.timestamps
    end
  end
end
