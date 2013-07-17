class City < ActiveRecord::Base
  attr_accessible :country_code, :latitude, :longitude, :name, :radius, :state_province
  validates_presence_of :name, :radius, :country_code, :state_province

  acts_as_gmappable :process_geocoding => true, :lat => "latitude", :lng => "longitude"

  #has_many :roles, :as => :authorizable
  #has_many :route_profiles
  #has_many :locations

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

end
