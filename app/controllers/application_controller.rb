class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :set_timezone

  private

  def set_timezone
    min = request.cookies["time_zone"].to_i
    Time.zone = ActiveSupport::TimeZone[-min.minutes]
    Rails.logger.info "*** TimeZone set to #{Time.zone.inspect}"
  end

end
