class String
  def negative?
    self.include?('-')
  end
end

class Fixnum
  def negative?
    self < 0
  end

  def to_time(format= :short)
    sign = self.negative? ? '-' : ''
    hh = (self/60.0).abs.to_i
    mm = (self.abs%60).to_s.rjust(2, '0')

    "#{sign}#{hh} #{format == :short ? 'h' : 'hours'} #{mm} #{format == :short ? 'mm' : 'minutes'}"
  end

  def to_minutes
    self*60
  end
end

class Date
  def weekend?
    (self.strftime("%A") == "Sunday" || self.strftime("%A") ==  "Saturday")? true : false
  end
end
