class Device < ActiveRecord::Base
  belongs_to :user
  has_many :checkins
  attr_accessible :default_language, :identifier, :platform, :platform_version, :user_id
end
