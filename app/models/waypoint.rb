class Waypoint < ActiveRecord::Base
  belongs_to :route
  belongs_to :location
  attr_accessible :location, :location_attributes,  :rank
  accepts_nested_attributes_for :location
end
