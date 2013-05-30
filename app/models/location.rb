class Location < ActiveRecord::Base
  mount_uploader :image, RouteImageUploader
  acts_as_gmappable :process_geocoding => :geocode?
  include ImageModel

  attr_accessible :address, :city, :description_en, :description_nl, :latitude, :longitude, :name_en, :name_nl, :postal_code, :image
  attr_accessible :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  has_many :waypoints
  has_many :routes, :through => :waypoints

  #attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  after_update :crop_image
  validate :validate_minimum_image_size

  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?))
  end

  def gmaps4rails_address
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address},  #{self.postal_code} #{self.city}"
  end


end
