require 'holidays'
require 'holidays/de'

class TimetracksController < ApplicationController
  respond_to :html, :js

  def index
    @date = params[:date].nil? ? Date.today : params[:date].to_date
    @month = (@date.beginning_of_month..@date.end_of_month).to_a
    @timetracks = Timetrack.find_by_month(@date, current_user)
    @timetrack = current_user.timetracks.find_by_date(@date) || current_user.timetracks.new(date: @date, start: Time.now)
    @absences = Absence.all
    @absence = Absence.find_or_initialize_by(date: @date)

    respond_with @timetracks
  end

  def create
    @timetrack = current_user.timetracks.new(timetrack_params)

    flash[:error] = 'Something went wrong.' unless @timetrack.save
    redirect_to timetracks_path(date: @timetrack.date)
  end

  def update
    @timetrack = current_user.timetracks.find(params[:id])

    flash[:error] = 'Something went wrong.' unless @timetrack.update_attributes(timetrack_params)
    redirect_to timetracks_path(date: @timetrack.date)
  end

  def destroy
    @timetrack = current_user.timetracks.find(params[:id])

    flash[:error] = 'Something went wrong.' unless @timetrack.delete
    redirect_to timetracks_path(date: @timetrack.date)
  end

  def timetrack_params
    params.require(:timetrack).permit(:date, :start, :finish, :duration)
  end

end
