class TimestampsController < ApplicationController


  def currentMonth()
    hash = Hash.new
    Timestamp.current_month.select do |t|
     hash[t.date.strftime('%d').to_i] = t
    end
    
    return hash
  end


  def index
    @timestamps = currentMonth()
    @timestamp = (Timestamp.today.blank?)? Timestamp.new : Timestamp.today.first
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @timestamps }
    end
  end

  def new
    @timestamps = currentMonth()
    @timestamp = Timestamp.new(:date => params[:date])
    
    Rails.logger.error "#{params.inspect}"
    @timestamp.endtime = "00:00"
    
    respond_to do |format|
      #format.js
      format.html { render :partial => "form" }
      format.json { render :json => @timestamp }
    end
  end

  def edit
    @timestamps = currentMonth()
    @timestamp = Timestamp.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render :json => @timestamp }
    end
  end

  def create
    @timestamp = Timestamp.new(params[:timestamp])

    respond_to do |format|
      if @timestamp.save
        format.html { redirect_to timestamps_url, :notice => 'Timestamp was successfully created.' }
        format.json { render :json => @timestamp, :status => :created, :location => @timestamp }
      else
        format.html { render :action => "new" }
        format.json { render :json => @timestamp.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @timestamp = Timestamp.find(params[:id])
 
    respond_to do |format|
      if @timestamp.update_attributes(params[:timestamp])
        format.html { redirect_to timestamps_url, :notice => 'Timestamp was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @timestamp.errors, :status => :unprocessable_entity }
      end
    end
  end

#  def destroy
#    @timestamp = Timestamp.find(params[:id])
#    @timestamp.destroy

#    respond_to do |format|
#      format.html { redirect_to timestamps_url }
#      format.json { head :ok }
#    end
#  end
end
