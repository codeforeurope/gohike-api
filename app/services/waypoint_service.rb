module Gohike
  module WaypointService

    def self.included(base)
      base.class_eval do
        include InstanceMethods
      end
    end

    module InstanceMethods

      def sorted_waypoints(route)

        first_waypoint = route.waypoints.where(:previous_waypoint_id => nil)

      end

      def waypoint_location_ids(waypoints)
        location_ids = []
        waypoints.each do |waypoint|
          location_ids << waypoint.location.id
        end
      end

    end


  end
end