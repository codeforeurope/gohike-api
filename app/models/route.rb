class Route < ActiveRecord::Base
  mount_uploader :image, RouteImageUploader
  mount_uploader :icon, RouteIconUploader
  attr_accessible :description, :icon, :image, :name_en, :name_nl, :description_en, :description_nl
  has_many :waypoints, :order => "rank ASC", :dependent => :destroy
  belongs_to :route_profile

  def image_data
    Base64.encode64(open(self.image.to_s) { |io| io.read }) unless self.image.to_s.blank?
  end
  def icon_data
    Base64.encode64(open(self.icon.to_s) { |io| io.read }) unless self.icon.to_s.blank?
  end
end
