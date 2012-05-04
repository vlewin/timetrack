WEEKDAYS = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

class TimetracksController < ApplicationController
  @@offset = {0=>6, 1=>0, 2=>1, 3=>2, 4=>3, 5=>4 }
  
  def index 
    @date = params[:date].nil? ? Date.today : params[:date].to_date # show current date
    @days = (@date.beginning_of_month..@date.end_of_month).to_a # all days in month e.g. 29, 30, 31

    @@offset[@days.first.wday].times{|i| @days.insert(i, nil)} # empty cells if first day of month is not monday

    @timetrack = Timetrack.find_by_date(@date)? Timetrack.find_by_date(@date) : Timetrack.new(:date => @date, :start => Time.now)
    @timetracks = Timetrack.month(Date.today) # TODO: find by params[:month]
     
    respond_to do |format|
      format.html
      format.js { render :partial => "timetrack" } # render partial if ajax call otherwise index.html
    end
  end
  
  def create
    @timetrack = Timetrack.new(params[:timetrack])
     respond_to do |format|
        if @timetrack.save
          # redirect to index or render "timetracks" ??? 
          format.html { redirect_to timetracks_url, :notice => 'Timestamp was successfully created.' }
        else
          format.html { redirect_to timetracks_url, :error => 'Something went wrong.' }
        end
    end
  end

  def update
    @timetrack = Timetrack.find(params[:id])
     respond_to do |format|
        if @timetrack.update_attributes(params[:timetrack])
          # redirect to index or render "timetracks" ??? 
          format.html { redirect_to timetracks_url, :notice => 'Timestamp was successfully created.' }
        else
          format.html { redirect_to timetracks_url, :error => 'Something went wrong.' }
        end
    end
  end
  
end
