class Location < ActiveRecord::Base
  acts_as_gmappable  :process_geocoding => :geocode?
  attr_accessible :address, :city, :description_en, :description_nl, :latitude, :longitude, :name_en, :name_nl, :postal_code
  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?))
  end

  def gmaps4rails_address
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address},  #{self.postal_code} #{self.city}"
  end
end
