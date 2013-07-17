class RegistrationsController < Devise::RegistrationsController
  before_filter :set_login_attributes, :only => :create

  private

  def set_login_attributes
    unless session["devise.login_attributes"].nil?

      resource_params[:login_attributes]= session["devise.login_attributes"]
    end
  end
end