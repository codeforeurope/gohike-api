class Location < ActiveRecord::Base
  mount_uploader :image, RouteImageUploader
  acts_as_gmappable :process_geocoding => :geocode?
  include ImageModel

  attr_accessible :address, :city, :latitude, :longitude, :postal_code, :image, :name, :description
  attr_accessible :crop_x, :crop_y, :crop_w, :crop_h, :translations_attributes
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h


  translates :name, :description, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations

  has_many :waypoints
  has_many :routes, :through => :waypoints

  #attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  after_update :crop_image
  validates_presence_of :name, :description
  validate :validate_minimum_image_size

  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?))
  end

  def gmaps4rails_address
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address},  #{self.postal_code} #{self.city}"
  end

  class Translation
    attr_accessible :locale, :name, :description
    validates_presence_of :name, :description
  end
end
