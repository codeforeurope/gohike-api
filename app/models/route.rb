class Route < ActiveRecord::Base
  mount_uploader :image, RouteImageUploader
  mount_uploader :icon, RouteIconUploader
  attr_accessible :description, :icon, :image, :name_en, :name_nl, :description_en, :description_nl
  has_many :waypointses
end
