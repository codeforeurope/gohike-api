class RouteProfile < ActiveRecord::Base
  mount_uploader :image, RouteImageUploader
  mount_uploader :icon, RouteIconUploader
  attr_accessible :description_en, :description_nl, :icon, :image, :name_en, :name_nl
  has_many :routes
end
