require 'holidays'
require 'holidays/de'

WEEKDAYS = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

class TimetracksController < ApplicationController
  def index
    @today = Date.today
    @date = params[:date].nil? ? @today : params[:date].to_date # show current date

    @timetrack = current_user.timetracks.find_by(:date => @date)
    @timetrack = @timetrack? @timetrack : Timetrack.new(:date => @date)

    @timetracks = current_user.timetracks

    respond_to do |format|
      format.html
      format.js { render :partial => "timetrack" } # render partial if ajax call otherwise index.html
    end
  end

  def create
    @timetrack = Timetrack.new(params[:timetrack])
    current_user.timetracks << @timetrack

    respond_to do |format|
      if current_user.save
        format.html { redirect_to timetracks_path({:date => @timetrack.date}) }
      else
        format.html { redirect_to timetracks_path({:date => @timetrack.date}), :error => 'Something went wrong.' }
      end
    end
  end

  def update
    @timetrack = current_user.timetracks.find(params[:id])

    respond_to do |format|
      if @timetrack.update_attributes(params[:timetrack])
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

end
