class Role < ActiveRecord::Base
  NAMES = %w"global_admin curator"

  belongs_to :authorizable, :polymorphic => true
  belongs_to :user
  attr_accessible :name, :user, :authorizable
end
