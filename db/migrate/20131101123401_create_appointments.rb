class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string : 

      t.timestamps
    end
  end
end
