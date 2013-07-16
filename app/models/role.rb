class Role < ActiveRecord::Base
  belongs_to :authorizable, :polymorphic => true
  belongs_to :user
  attr_accessible :name, :user, :authorizable
end
