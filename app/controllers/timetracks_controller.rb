require 'holidays'
require 'holidays/de'

class TimetracksController < ApplicationController
  def index
    @date = params[:date].nil? ? Date.today : params[:date].to_date # show current date
    @month = (@date.beginning_of_month..@date.end_of_month).to_a # all days in month e.g. 29, 30, 31

    if Timetrack.find_by_date(@date, current_user)
      @timetrack = Timetrack.find_by_date(@date, current_user)
    else
      @timetrack = Timetrack.new(:date => @date, :start => Time.now)
      @timetrack.user = current_user
    end

    @timetracks = Timetrack.find_by_month(@date, current_user)

    respond_to do |format|
      puts format.inspect
      format.html
      format.js { render :partial => "timetrack" } # render partial if ajax call otherwise index.html
    end
  end

  def create
    @timetrack = Timetrack.new(timetrack_params)
    @timetrack.user_id = current_user.id

    respond_to do |format|
      if @timetrack.save
        format.html { redirect_to timetracks_path({:date => @timetrack.date}) }
      else
        format.html { redirect_to timetracks_path({:date => @timetrack.date}), :error => 'Something went wrong.' }
      end
    end
  end

  def update
    @timetrack = current_user.timetracks.find(params[:id])

    respond_to do |format|
      if @timetrack.update_attributes(timetrack_params)
        format.html { redirect_to timetracks_path({:date => @timetrack.date}) }
      else
        format.html { redirect_to timetracks_path({:date => @timetrack.date}), :error => 'Something went wrong.'}
      end
    end
  end

  def destroy
    @timetrack = current_user.timetracks.find(params[:id])

    respond_to do |format|
      if @timetrack.delete
        format.html { redirect_to timetracks_path({:date => @timetrack.date}) }
      else
        format.html { redirect_to timetracks_path({:date => @timetrack.date}), :error => 'Something went wrong.'}
      end
    end
  end

  def timetrack_params
    params.require(:timetrack).permit(:date, :start, :finish, :duration)
  end

end
