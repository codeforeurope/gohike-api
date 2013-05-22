class Waypoint < ActiveRecord::Base
  belongs_to :route
  belongs_to :location
  belongs_to :previous_location, :class_name => "Location"
  belongs_to :next_location, :class_name => "Location"
  # attr_accessible :title, :body
end
