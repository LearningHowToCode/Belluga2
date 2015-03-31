class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :set_device_type

  private
  def set_device_type
    binding.pry
    request.variant = :phone if browser.mobile?
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:profile_type, :name]
  end
  
  def set_locale
  	I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
  	{ locale: I18n.locale }
  end

end
