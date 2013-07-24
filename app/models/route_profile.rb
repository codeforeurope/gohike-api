class RouteProfile < ActiveRecord::Base
  include ImageModel
  mount_uploader :image, RouteProfileImageUploader

  MIN_HEIGHT = 200
  MIN_WIDTH = 200

  attr_accessible :description, :image, :name, :translations_attributes, :city_id

  belongs_to :city
  has_many :routes, :dependent => :destroy

  translates :name, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations
  validates_presence_of :name
  after_update :crop_image
  validate :validate_minimum_image_size

  scope :in_cities, ->(city_ids) { where("city_id IN (?)", city_ids) }
  scope :in_city, ->(city_id) {
    where(:city_id => city_id)
  }

  def icon_data
    Base64.encode64(open(self.icon.to_s) { |io| io.read }) unless self.icon.to_s.blank?
  end


  class Translation
    attr_accessible :locale, :name
    validates_presence_of :name
  end

  def published_routes
    routes.where(:published => true)
  end

end
