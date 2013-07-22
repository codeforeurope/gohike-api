class RouteProfile < ActiveRecord::Base
  include ImageModel
  mount_uploader :image, RouteImageUploader
  mount_uploader :icon, RouteIconUploader

  translates :name, :description, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations

  attr_accessible :description, :icon, :image, :name, :translations_attributes, :city_id
  attr_accessible :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  belongs_to :city
  has_many :routes, :dependent => :destroy

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
    attr_accessible :locale, :name, :description
    validates_presence_of :name, :description
  end
end
