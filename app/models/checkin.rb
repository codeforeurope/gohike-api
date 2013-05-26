class Checkin < ActiveRecord::Base
  belongs_to :route
  belongs_to :location
  attr_accessible :stamp
end
