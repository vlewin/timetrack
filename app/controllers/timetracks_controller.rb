WEEKDAYS = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']

class TimetracksController < ApplicationController
  # TODO: show days of previous month instead of nil
  @@offset = {0=>6, 1=>0, 2=>1, 3=>2, 4=>3, 5=>4, 6=>5 }

  def index
    @date = params[:date].nil? ? Date.today : params[:date].to_date # show current date
    @days = (@date.beginning_of_month..@date.end_of_month).to_a # all days in month e.g. 29, 30, 31

    @@offset[@days.first.wday].times{|i| @days.insert(i, nil)} # empty cells if first day of month is not monday

    @timetrack = Timetrack.find_by_date(@date)? Timetrack.find_by_date(@date) : Timetrack.new(:date => @date, :start => Time.now.strftime("%H:%M"))
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
        format.html { redirect_to timetracks_path({:date => @timetrack.date}) }
      else
        format.html { redirect_to timetracks_path({:date => @timetrack.date}), :error => 'Something went wrong.' }
      end
    end
  end

  def update
    @timetrack = Timetrack.find(params[:id])

    respond_to do |format|
      if @timetrack.update_attributes(params[:timetrack])
        format.html { redirect_to timetracks_path({:date => @timetrack.date}) }
      else
        format.html { redirect_to timetracks_path({:date => @timetrack.date}), :error => 'Something went wrong.'}
      end
    end
  end

  def destroy
    @timetrack = Timetrack.find(params[:id])
    @timetrack.destroy

    respond_to do |format|
      format.html { render :nothing => true, :status => 200, :content_type => 'text/html' }
    end
  end

end
