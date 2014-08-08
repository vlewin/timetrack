class Timetrack < ActiveRecord::Base
  before_save :duration

  # VALIDATORS
  validates :date, :presence => true
  validates :date, :uniqueness => { :scope => :user_id }

  # attr_accessible :date, :start, :finish, :duration, :user_id
  belongs_to :user

  PAUSE = 30

  def self.find_by_date(date, user)
    self.where(:date => date, :user_id => user).first
  end

  def self.find_by_month(date, user)
    timestamps = Hash.new
    self.where("date >= ? AND date <= ? AND user_id =?", date.beginning_of_month, date.end_of_month, user.id).select{|t| timestamps[t.date] = t}
    timestamps
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
