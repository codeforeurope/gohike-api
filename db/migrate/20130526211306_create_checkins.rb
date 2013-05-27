class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.references :device
      t.references :route
      t.references :location
      t.datetime :stamp

      t.timestamps
    end
    add_index :checkins, :device_id
    add_index :checkins, :route_id
    add_index :checkins, :location_id
  end
end
