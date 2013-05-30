class Location < ActiveRecord::Base
  mount_uploader :image, RouteImageUploader
  acts_as_gmappable :process_geocoding => :geocode?

  attr_accessible :address, :city, :description_en, :description_nl, :latitude, :longitude, :name_en, :name_nl, :postal_code, :image, :crop_x, :crop_y, :crop_w, :crop_h

  has_many :waypoints
  has_many :routes, :through => :waypoints

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  after_update :crop_image


  validate :validate_minimum_image_size

  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?))
  end

  def gmaps4rails_address
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address},  #{self.postal_code} #{self.city}"
  end

  def image_data
    Base64.encode64(open(self.image.to_s) { |io| io.read }) unless self.image.to_s.blank?
  end

  def crop_image
    image.recreate_versions! if crop_x.present?
  end

  MIN_WIDTH = 570
  MIN_HEIGHT = 380

  def validate_minimum_image_size
    img = MiniMagick::Image.open(image_url)
    unless img[:width] >= MIN_WIDTH && img[:height] >= MIN_HEIGHT
      errors.add :image, :image_minimum_size, :min_width => MIN_WIDTH, :min_height => MIN_HEIGHT
    end
  end
end
