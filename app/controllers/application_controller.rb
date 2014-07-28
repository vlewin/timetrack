class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :set_timezone
  # before_action :authenticate_user!, :set_timezone


  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
  end

  private

  def set_timezone
#    cookie_tz = request.cookies["time_zone"].to_i

#    if Time.now.isdst
#      if cookie_tz.negative?
#        cookie_tz  = cookie_tz + 3600
#      else
#        cookie_tz  = cookie_tz - 3600
#      end
#    end

#    unless cookie_tz == Time.now.utc_offset
#      Time.zone = ActiveSupport::TimeZone[-cookie_tz]
#    end
  end
end
