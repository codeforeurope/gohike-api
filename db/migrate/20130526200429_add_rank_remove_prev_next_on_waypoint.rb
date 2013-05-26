class AddRankRemovePrevNextOnWaypoint < ActiveRecord::Migration
  def change
    add_column :waypoints, :rank, :integer
    remove_columns :waypoints, :previous_waypoint_id, :next_waypoint_id
  end

end
