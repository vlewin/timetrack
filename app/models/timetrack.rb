class Timetrack < ActiveRecord::Base
  before_save :pause, :duration

  validates :date, presence: true
  validates :date, uniqueness: { scope: :user_id }

  belongs_to :user

  HOURS_OF_WORK = 8

  def self.find_by_month(date, user)
    user.timetracks.where('date >= ? AND date <= ?', date.beginning_of_month, date.end_of_month)
  end

  def balance
    if self.persisted?
      ((duration - pause) - HOURS_OF_WORK.to_minutes)
    else
      0
    end
  end

  # § 4 ArbZG. (http://www.gesetze-im-internet.de/arbzg/__4.html)
  def pause
    if (duration_in_hours <= 6)
      0
    elsif (duration_in_hours > 6 && duration_in_hours <= 9)
      30
    elsif (duration_in_hours > 9)
      45
    else
      Rails.logger.error("Cann't calculate pause")
      return 0
    end
  end

  def duration
    (finish.nil?) ? 0 : ((finish - start) / 60).to_i
  end

  def duration_in_hours
    duration / 60.0
  end

  # FIXME: Move to decorator
  def duration_in_words
    duration.to_time
  end

  def duration_in_percent
    ((duration) * 100) / 510
  end
end
