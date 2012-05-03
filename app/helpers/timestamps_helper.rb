module TimestampsHelper
  def lastday(date)
    (Date.new(date.strftime("%Y").to_i, 12, 31) << (12-date.strftime("%m").to_i)).day
  end
  
  def weekrange(date)
    
    lastDay = (Date.new(date.strftime("%Y").to_i, 12, 31) << (12-date.strftime("%m").to_i)).day
    
    first = Date.new(date.strftime("%Y").to_i, date.strftime("%m").to_i, 1).strftime("%U").to_i
    last = Date.new(date.strftime("%Y").to_i, date.strftime("%m").to_i, lastDay).strftime("%U").to_i
    
    range = Range.new(first,last)
    
    
  end
  

end
