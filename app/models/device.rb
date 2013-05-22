class Device < ActiveRecord::Base
  belongs_to :user
  attr_accessible :default_language, :identifier, :platform, :platform_version
end
