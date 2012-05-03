WEEKDAYS = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

class TimetracksController < ApplicationController
  @@offset = {0=>6, 1=>0, 2=>1, 3=>2, 4=>3, 5=>4 }
  
  def index 
    @timetracks = Timetrack.all
    
    @timetracks = Timetrack.month(Date.today)

    @date = params[:date].nil? ? Date.today : params[:date].to_date
    @days = (@date.beginning_of_month..@date.end_of_month).to_a

    @@offset[@days.first.wday].times do |i|
      @days.insert(i, nil)
    end
    
    respond_to do |format|
      format.html
      format.json { render :json => @timetracks }
      format.js { render :partial => "timetrack" }
    end

  end
end
