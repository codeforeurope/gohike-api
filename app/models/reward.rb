class Reward < ActiveRecord::Base
  MIN_WIDTH = 480
  MIN_HEIGHT = 480
  mount_uploader :image, RewardUploader
  belongs_to :route

  attr_accessible :description, :image, :name, :route_id, :translations_attributes

  translates :name, :description, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations


  validate :validate_image_size_and_ratio
  validates_presence_of :name, :description, :route_id

  class Translation
    attr_accessible :locale, :name, :description
    validates_presence_of :name, :description
  end

  def image_data
    Base64.encode64(open(self.image.to_s) { |io| io.read }) unless self.image.to_s.blank?
  end

  def validate_image_size_and_ratio
    unless image.blank?
      if image.file.respond_to?(:sanitize_regexp)
        img = MiniMagick::Image.read(image.file)
      else

        img = MiniMagick::Image.open(image.url)
      end
      unless (img[:width] >= MIN_WIDTH && img[:height] >= MIN_HEIGHT) && (img[:width]/img[:height] == 1)
        errors.add :image, :image_minimum_size, :min_width => MIN_WIDTH, :min_height => MIN_HEIGHT
      end
    end
  end
end
