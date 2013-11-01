class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :user
      t.references :page
      t.datetime :start_time
      t.timestamps
    end
  end
end
