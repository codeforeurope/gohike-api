class Route < ActiveRecord::Base
  include ImageModel
  mount_uploader :image, RouteImageUploader
  mount_uploader :icon, RouteIconUploader
  attr_accessible :description, :icon, :image, :name_en, :name_nl, :description_en, :description_nl
  attr_accessible :crop_x, :crop_y, :crop_w, :crop_h
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  has_many :waypoints, :order => "rank ASC", :dependent => :destroy
  belongs_to :route_profile
  has_one :reward, :as => :rewardable

  def icon_data
    Base64.encode64(open(self.icon.to_s) { |io| io.read }) unless self.icon.to_s.blank?
  end

  after_update :crop_image
  validate :validate_minimum_image_size
end
