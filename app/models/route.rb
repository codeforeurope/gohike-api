class Route < ActiveRecord::Base
  include ImageModel
  mount_uploader :image, RouteImageUploader
  mount_uploader :icon, RouteIconUploader
  attr_accessible :description, :icon, :image, :name, :description, :translations_attributes, :city_id, :route_profile_id

  attr_accessible :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  translates :name, :description, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations


  has_many :waypoints, :order => "rank ASC", :dependent => :destroy
  belongs_to :route_profile
  belongs_to :city
  has_one :reward



  scope :in_city, ->(city_id) {
    where(:city_id => city_id)
  }

  def icon_data
    Base64.encode64(open(self.icon.to_s) { |io| io.read }) unless self.icon.to_s.blank?
  end

  after_update :crop_image
  validate :validate_minimum_image_size
  validates_presence_of :name, :description, :city_id, :route_profile_id

  class Translation
    attr_accessible :locale, :name, :description
    validates_presence_of :name, :description
  end
end
