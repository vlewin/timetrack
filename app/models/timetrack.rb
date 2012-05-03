class Timetrack < ActiveRecord::Base
  before_save :to_timestamp, :duration
  
  def initialize(*params)
    super(*params)
    if (@new_record)
      self.date = Date.today
    end
  end
  
  def to_timestamp
    self.start = self.start.to_i
    self.finish = self.finish.to_i
  end
  
  def duration
    self.duration = self.finish - self.start
  end
  
  def self.month(date)
    timestamps = Hash.new
    self.where('date > ? AND date < ?', date.beginning_of_month, date.end_of_month).select{|t| timestamps[t.date] = t}
    timestamps
  end
end
