class Timetrack < ActiveRecord::Base
  before_save :duration
  after_find :human_friendly

  # VALIDATORS
  validates :date, :presence => true
  validates :date, :uniqueness => { :scope => :user_id }
  validate :start_and_end_time_cannot_be_equal

  attr_accessible :date, :start, :finish, :duration, :user_id
  belongs_to :user

  @@day = 28800
  @@pause = 1800

  def initialize(*params)
    super(*params)
  end

  def start_and_end_time_cannot_be_equal
    if self.finish && self.finish.to_i <= self.start.to_i
      errors.add(:timetrack, "End time can't be lower or equal to start time")
    end
  end

  def self.balance(user)
    number = self.count(:conditions => {:user_id => user})
    self.sum(:duration, :conditions => {:user_id => user}) - (number*@@day)
  end

  def exists?
    (Timetrack.where(:date=>self.date, :user_id=>self.user_id).empty?)? false : true
  end

  def duration
    self.duration = (self.finish.nil?)? nil : self.finish - self.start
  end

  def self.by_date(date, user)
    self.where(:date => date, :user_id => user).first
  end

  def self.by_month(date, user)
    timestamps = Hash.new
    self.where("date >= ? AND date <= ? AND user_id =?", date.beginning_of_month, date.end_of_month, user.id).select{|t| timestamps[t.date] = t}
    timestamps
  end

  def human_friendly
    self.start = self.start.strftime("%H:%M") if self.start
    self.finish = self.finish.strftime("%H:%M") if self.finish
    self.duration = (self.duration.nil?)? "N/A" : (self.duration/3600).round(2) if self.duration
  end

end
