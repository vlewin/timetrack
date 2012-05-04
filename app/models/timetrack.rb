class Timetrack < ActiveRecord::Base
  before_save :to_timestamp, :duration
  after_find :to_timestring, :duration_human_friendly
  
  attr_accessible :date, :start, :finish
  
  def initialize(*params)
    Rails.logger.error "*** Initialize #{params.inspect}"
    super(*params)
  end
  
  def to_timestamp
    #ruby-1.9.2-p0 :003 > Time.new(2008,6,21, 13,30,0, "+09:00").utc
    # convert time timestamp to time string e.g. 139999999 => "08:00"
    self.start = self.start.to_i
    self.finish = self.finish.to_i
  end

  def to_timestring
    Rails.logger.error "AFTER FINISH #{self.start}"
    # convert time timestamp to time string e.g. 139999999 => "08:00"
    self.start = Time.at(self.start).strftime("%H:%M")
    Rails.logger.error "AFTER FINISH #{self.finish}"
    self.finish = Time.at(self.finish).strftime("%H:%M")
  end
  
  # TODO: is not triggered ??? 
  def duration
    self.duration = self.finish - self.start
  end
  
  def duration_human_friendly
    self.duration = 7
  end
  
  def self.month(date)
    timestamps = Hash.new
    self.where('date > ? AND date < ?', date.beginning_of_month, date.end_of_month).select{|t| timestamps[t.date] = t}
    timestamps
  end
end
