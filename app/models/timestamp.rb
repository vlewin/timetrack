class Timestamp < ActiveRecord::Base
  # FILTERS
  after_initialize :init
  before_save :round_up, :calculate_duration

  # VALIDATORS
  validates :date, :presence => true, :uniqueness => true
  validates :starttime, :presence => true, :format => {:with => /^(([0-9])|([0-1][0-9])|([2][0-3])):(([0-9])|([0-5][0-9]))$/i}
  validates :endtime, :presence => true, :format => {:with => /^(([0-9])|([0-1][0-9])|([2][0-3])):(([0-9])|([0-5][0-9]))$/i}

  #validate :ensure_endtime_must_be_greater_than_starttimetime

  # SCOPES
  scope :today, :conditions => ["date =?", Date.today]
 # scope :current_month, :conditions => ["strftime('%m', date) <=?", Date.today], :order => "date"

  scope :current_month, lambda { |date|
    where('date > ? AND date < ?', DateTime.parse(date).beginning_of_month, DateTime.parse(date).end_of_month)
  }

  scope :find_by_month, lambda { |month|
    {
      :conditions => ["strftime('%m', date) =?", month.to_s.match('0')? month : "0#{month}"],
      :order => "date"
    }
  }

  def self.balance
    balance =  self.sum(:duration) - self.count*8
    hours = balance.to_i;
    minutes = (balance - balance.to_i)
    minutes = (minutes * 60).to_i
    "#{hours} hours #{minutes} minutes"
  end

  def days_in_month
    (Date.new(self.date.strftime("%Y").to_i, 12, 31) << (12-self.date.strftime("%m").to_i)).day
  end

  private

  def init
    now = Time.new
    today = now.strftime("%F")
    self.date = (date.blank?)? today : date
    self.starttime = (starttime.blank?)? "#{now.hour}:#{now.min}".roundup(5) : starttime
    self.endtime = (endtime.blank?)? "#{now.hour}:#{now.min}".roundup(5) : endtime
  end

  def round_up
    self.starttime = self.starttime.roundup(5)
    self.endtime = self.endtime.roundup(5)
  end

  def calculate_duration
    stime = number(starttime)
    etime = number(endtime)
    self.duration = (self.duration.nil?)? 0 : ((etime - stime-30)/60.to_f).round(2)
  end

  def number(time)
    hh,mm = time.split(':')
    number = hh.to_i*60 + mm.to_i
  end



#  def ensure_endtime_must_be_greater_than_starttimetime
#    errors.add(:end, "time must be greater than starttime time") unless(number(self.end) > number(self.starttime))
#  end

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

#class Fixnum
#  def roundup(nearest)
#    self % nearest == 0 ? self : self + nearest - (self % nearest)
#  end
#end
