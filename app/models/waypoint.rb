class Waypoint < ActiveRecord::Base
  belongs_to :route
  belongs_to :location
  belongs_to :previous_waypoint, :class_name => "Waypoint"
  belongs_to :next_waypoint, :class_name => "Waypoint"
  attr_accessor :rank
  attr_accessible :location, :location_attributes
  accepts_nested_attributes_for :location, :previous_waypoint, :next_waypoint
end
