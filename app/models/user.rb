class User < ActiveRecord::Base
  before_create :add_login
  # Include default devise modules. Others available are:
  # :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :login_attributes

  has_many :roles
  has_many :logins, :class_name => 'UserProvider', :foreign_key => :user_id
  attr_accessor :login_attributes


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

  def has_active_fb_token?
    logins.where(:provider => :facebook).first_or_initialize.expires_at > Time.now.to_i
  end

  def self.from_omniauth(auth)
    login = UserProvider.where(auth.slice(:provider, :uid)).first
    if login.nil?
      user = where(:email => auth[:info][:email]).first_or_initialize
    else
      user = login.user
    end

    if user.persisted?

      if login.nil?
        user.logins.build auth.slice(:provider, :uid)
        user.save
        #in the rare case that the FB ID will differ (something definitely fishy)
      else
        login.update_attributes auth[:credentials].slice(:token, :expires_at)
      end
    end
    user
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && !logins.empty?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  private
  def add_login
    unless login_attributes.nil?
      logins.build login_attributes
    end
  end
end
