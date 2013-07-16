class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    home_path
  end

  def after_sign_out_path_for(resource)
    home_path
  end

  before_filter :set_locale

  def set_locale
    if params[:locale].blank?
      unless current_user.nil? || current_user.locale.nil?
        I18n.locale = current_user.locale
      else
        I18n.locale = extract_locale_from_header
      end

    else
      I18n.locale = params[:locale]
    end
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end

  private
  def extract_locale_from_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first || I18n.default_locale
  end
end
