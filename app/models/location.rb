class Location < ActiveRecord::Base
  mount_uploader :image, LocationImageUploader
  acts_as_gmappable :process_geocoding => :geocode?
  include ImageModel

  attr_accessible :address, :city, :latitude, :longitude, :postal_code, :image, :name, :description, :city_id, :translations_attributes

  translates :name, :description, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations, :allow_destroy => true

  has_many :waypoints
  has_many :routes, :through => :waypoints
  belongs_to :network, :class_name => "City", :foreign_key => :city_id

  scope :in_city, ->(city_id) {
    where(:city_id => city_id)
  }

  scope :in_cities, ->(city_ids) {
    where("city_id IN (?)", city_ids.split(","))
  }

  after_update :crop_image
  validates_presence_of :name, :description
  validate :validate_minimum_image_size
  validates_length_of :name, :maximum => 35
  validates_length_of :description, :maximum => 540


  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?))
  end

  def gmaps4rails_address
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address},  #{self.postal_code} #{self.city}"
  end

  #def self.default_scope
  #
  #  #where published: true
  #end

  class Translation
    attr_accessible :locale, :name, :description
    validates_presence_of :name, :description
    validates_length_of :name, :maximum => 35
    validates_length_of :description, :maximum => 540
  end


end
