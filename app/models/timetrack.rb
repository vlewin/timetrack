class Timetrack < ActiveRecord::Base
#  before_save :to_timestamp,
  before_save :duration
  after_find :duration_human_friendly

  # VALIDATORS
  validates :date, :presence => true
  validates :date, :uniqueness => { :scope => :user_id }
  #validates :start, :presence => true, :format => {:with => /^(([0-9])|([0-1][0-9])|([2][0-3])):(([0-9])|([0-5][0-9]))$/i}
  #validates :finish, :presence => true, :format => {:with => /^(([0-9])|([0-1][0-9])|([2][0-3])):(([0-9])|([0-5][0-9]))$/i}

  attr_accessible :date, :start, :finish, :duration, :user_id

  belongs_to :user

  PAUSE = 30

  def initialize(*params)
    super(*params)
  end

  def self.balance(user)
    user_balanace = self.sum(:duration, :conditions => {:user_id => user})
    time =  (user_balanace/3600) - (self.count(:conditions => {:user_id => user})*8)
    hours = time.to_i;
    minutes = (time - time.to_i)
    minutes = (minutes * 60).to_i

    balance = Hash.new
    balance[:negative] = minutes.negative?
    balance[:value] = "#{hours.abs} hours #{minutes.abs} minutes"

    balance
  end

  def to_timestamp
    self.start = self.start.to_i
    self.finish = (self.finish.nil?)? 0 : self.finish.to_i
  end

#  def to_timestring
#    # convert time timestamp to time string e.g. 139999999 => "08:00"
#    self.start = Time.at(self.start).strftime("%H:%M")
#    self.finish = (self.finish == 0)? self.finish : Time.at(self.finish).strftime("%H:%M")
#  end

  def exists?
#    self.where("date >= ? AND date <= ? AND user_id =?", self.date, self.user.id)
    return (Timetrack.where(:date=>self.date, :user_id=>self.user_id).empty?)? false : true
  end

  def duration
    self.duration =  (self.finish.nil?) ? 0 : (self.finish - self.start) - (PAUSE*60)
  end

  def duration_human_friendly
    self.duration = (self.duration.nil?)? "N/A" : (self.duration/3600).round(2)
  end

  def self.by_date(date, user)
    self.where(:date => date, :user_id => user).first
  end

  def self.by_month(date, user)
    timestamps = Hash.new
    self.where("date >= ? AND date <= ? AND user_id =?", date.beginning_of_month, date.end_of_month, user.id).select{|t| timestamps[t.date] = t}
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

    time
  end
end

class Numeric
  def negative?
    self.to_s =~ /^-/
  end
end

class Date
  def weekend?
    (self.strftime("%A") == "Sunday" || self.strftime("%A") ==  "Saturday")? true : false
  end
end
