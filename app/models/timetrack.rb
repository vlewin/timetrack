class Timetrack < ActiveRecord::Base
  before_save :duration

  validates :date, :presence => true
  validates :date, :uniqueness => { :scope => :user_id }

  belongs_to :user

  PAUSE = 30

  def self.find_by_month(date, user)
    user.timetracks.where('date >= ? AND date <= ?', date.beginning_of_month, date.end_of_month)
  end

  # FIXME: move to decorator
  def self.balance(user)
    balance =  (user.timetracks.sum(:duration)/3600) - (user.timetracks.count*8)
    hours = balance.to_i
    minutes = ((balance - hours)* 60).round

    { negative: minutes.negative?, value: "#{hours.abs} hours #{minutes.abs} minutes" }
  end

  def duration
    self.duration =  (self.finish.nil?) ? 0 : (self.finish - self.start) - (PAUSE*60)
  end

  # FIXME: Move to decorator
  def duration_in_words
    hh = (self.duration/3600).to_i
    mm = (self.duration.to_i%3600)/60
    "#{hh} h #{mm.to_s.rjust(2, '0')} min"
  end

  # FIXME: Move to decorator
  def duration_in_hours
    start = self.start.strftime("%H:%M") if self.start
    finish = self.finish.strftime("%H:%M") if self.finish
    duration = (!self.duration || self.duration == 0)? "N/A" : (self.duration/3600).round(2)
  end

end
