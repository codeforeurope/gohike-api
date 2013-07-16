class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,:token_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :roles

  def role? (name, resource = nil)
    if resource.nil?
      !roles.where(:name => name, :authorizable_type => nil, :authorizable_id => nil).empty?
    else
      if resource.class.name == :class.to_s.camelize
        !roles.where(:name => name, :authorizable_type => resource.to_s).empty?
      else
        !roles.where(:name => name, :authorizable_type => resource.class.name, :authorizable_id => resource.id).empty?
      end
    end
  end
end
