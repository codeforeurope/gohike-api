class Reward < ActiveRecord::Base
  MIN_WIDTH = 480
  MIN_HEIGHT = 480
  mount_uploader :image, RewardUploader
  belongs_to :rewardable, :polymorphic => true
  attr_accessible :description_en, :description_nl, :image, :name_en, :name_nl, :rewardable_id, :rewardable_type


  validate :validate_image_size_and_ratio
  validates_presence_of :name_en, :description_en, :name_nl, :description_nl, :rewardable_id, :rewardable_type


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
