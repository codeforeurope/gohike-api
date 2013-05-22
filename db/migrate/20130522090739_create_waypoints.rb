class CreateWaypoints < ActiveRecord::Migration
  def change
    create_table :waypoints do |t|
      t.references :route
      t.references :location
      t.references :previous_location
      t.references :next_location

      t.timestamps
    end
    add_index :waypoints, :route_id
    add_index :waypoints, :location_id
    add_index :waypoints, :previous_location_id
    add_index :waypoints, :next_location_id
  end
end
