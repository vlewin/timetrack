class Timetrack < ActiveRecord::Base
  before_save :to_timestamp, :duration
  after_find :to_timestring, :duration_human_friendly

  # VALIDATORS
  validates :date, :presence => true, :uniqueness => true
  #validates :start, :presence => true, :format => {:with => /^(([0-9])|([0-1][0-9])|([2][0-3])):(([0-9])|([0-5][0-9]))$/i}
  #validates :finish, :presence => true, :format => {:with => /^(([0-9])|([0-1][0-9])|([2][0-3])):(([0-9])|([0-5][0-9]))$/i}

  attr_accessible :date, :start, :finish, :duration

  PAUSE = 30

  def initialize(*params)
    super(*params)
  end

  def self.balance
    balance =  (self.sum(:duration)/3600) - (self.count*8)
    hours = balance.to_i;
    minutes = (balance - balance.to_i)
    minutes = (minutes * 60).to_i

    balance = Hash.new
    balance[:negative] = minutes.negative?
    balance[:value] = "#{hours} hours #{minutes.abs} minutes"

    return balance
  end

  def to_timestamp
    #ruby-1.9.2-p0 :003 > Time.new(2008,6,21, 13,30,0, "+09:00").utc
    # convert time timestamp to time string e.g. 139999999 => "08:00"
    self.start = self.start.to_i
    self.finish = self.finish.to_i
  end

  def to_timestring
    # convert time timestamp to time string e.g. 139999999 => "08:00"
    self.start = Time.at(self.start).strftime("%H:%M")
    self.finish = Time.at(self.finish).strftime("%H:%M")
  end

  # TODO: is not triggered ???
  def duration
    self.duration = (self.finish - self.start) - (PAUSE*60)
  end

  def duration_human_friendly
    self.duration = (self.duration/3600).round(2)
  end

  def self.month(date)
    timestamps = Hash.new
    Rails.logger.error "BM #{date.beginning_of_month} EM #{date.end_of_month}"
    self.where('date >= ? AND date <= ?', date.beginning_of_month, date.end_of_month).select{|t| timestamps[t.date] = t}
    timestamps
  end
end

class String
  def roundup(base)
    hh,mm = self.split(':')
    hh = hh.to_i
    mm = mm.to_i
    mm = mm % base == 0? mm : mm + base - (mm % base)

    if mm < 60
      mm = mm > 0? mm : "00"
      time = "#{hh}:#{mm}"
      return time
    else
      return "#{hh+1}:00"
    end

    Rails.logger.error "HH #{hh} MM #{mm} TIME #{time}"
    return time
  end
end

class Numeric
  def negative?
    self.to_s =~ /^-/
  end
end
