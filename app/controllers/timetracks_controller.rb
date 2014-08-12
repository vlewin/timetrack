require 'holidays'
require 'holidays/de'

class TimetracksController < ApplicationController
  def index
    @date = params[:date].nil? ? Date.today : params[:date].to_date
    @month = (@date.beginning_of_month..@date.end_of_month).to_a
    @timetracks = Timetrack.find_by_month(@date, current_user)
    @timetrack = current_user.timetracks.find_by_date(@date) || current_user.timetracks.new(date: @date, start: Time.now)

    respond_to do |format|
      format.html
      format.js { render partial: 'timetrack' }
    end
  end

  def create
    @timetrack = current_user.timetracks.new(timetrack_params)
    respond_to do |format|
      if @timetrack.save!
        format.html { redirect_to timetracks_path({date: @timetrack.date}) }
      else
        format.html { redirect_to timetracks_path({date: @timetrack.date}), error: 'Something went wrong.' }
      end
    end
  end

  def update
    @timetrack = current_user.timetracks.find(params[:id])

    respond_to do |format|
      if @timetrack.update_attributes(timetrack_params)
        format.html { redirect_to timetracks_path({date: @timetrack.date}) }
      else
        format.html { redirect_to timetracks_path({date: @timetrack.date}), error: 'Something went wrong.'}
      end
    end
  end

  def destroy
    @timetrack = current_user.timetracks.find(params[:id])

    respond_to do |format|
      if @timetrack.delete
        format.html { redirect_to timetracks_path({date: @timetrack.date}) }
      else
        format.html { redirect_to timetracks_path({date: @timetrack.date}), error: 'Something went wrong.'}
      end
    end
  end

  def timetrack_params
    params.require(:timetrack).permit(:date, :start, :finish, :duration)
  end

end
