class City < ActiveRecord::Base
  attr_accessible :country_code, :latitude, :longitude, :name, :radius, :state_province, :top_left_lat, :top_left_lon, :bottom_right_lat, :bottom_right_lon
  validates_presence_of :name, :radius, :country_code, :state_province
  validates_uniqueness_of :name, :scope => [:country_code, :state_province], :case_sensitive => false

  acts_as_gmappable :process_geocoding => true, :lat => "latitude", :lng => "longitude"

  #has_many :roles, :as => :authorizable
  #has_many :route_profiles
  has_many :locations
  has_many :routes
  has_many :route_profiles


  def gmaps4rails_address
    #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    fullname
  end

  def country_name
    Carmen::Country.coded(country_code).name
  end

  def fullname
    if country_code == "US"
      "#{self.name}," + (self.state_province.present? ? " #{self.state_province}" : "")
    else
      "#{self.name}," + (self.state_province.present? ? " #{self.state_province}," : "") +" #{self.country_name}"
    end

  end

  def self.by_device_location(latitude, longitude)
     self.where("top_left_lat >= #{latitude} and top_left_lon <= #{longitude} AND bottom_right_lat <= #{latitude} and bottom_right_lon >= #{longitude}")
  end

  def publishable_profiles
    route_profiles.all(:joins => :routes,
        :conditions => "routes.published_key IS NOT NULL",
        :group => 'route_profiles.id',
        :order => 'priority',
        :having => "count(routes.id) > 0")
  end

end
