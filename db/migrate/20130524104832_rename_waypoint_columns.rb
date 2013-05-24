class RenameWaypointColumns < ActiveRecord::Migration
  def change
    rename_column :waypoints, :next_location_id, :next_waypoint_id
    rename_column :waypoints, :previous_location_id, :previous_waypoint_id
  end

end
