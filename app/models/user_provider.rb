class UserProvider < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :uid, :token, :expires_at
end
