class Route < ActiveRecord::Base
  include ImageModel
  mount_uploader :image, RouteImageUploader
  #mount_uploader :icon, RouteIconUploader
  attr_accessible :description, :icon, :image, :name, :description, :translations_attributes, :city_id, :route_profile_id

  translates :name, :description, :fallbacks_for_empty_translations => true do
    attr_accessible :locale, :name, :description
    validates_presence_of :locale, :name, :description
  end

  accepts_nested_attributes_for :translations, :allow_destroy => true


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


  def validate_for_publishing
    return true
    locales = translated_locales
    waypoints.joins(:location).each do |waypoint|
      locales.each do |locale|
        if waypoint.location.translation_for(locale, false).blank?
          errors.add(:base, :missing_translation, :location => waypoint.location.name, :l => locale)
        end
      end
    end
    errors.empty? ? true : false
  end
end
