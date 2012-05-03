module ApplicationHelper
  def isWeekend?(date)
    bool = false
    bool = (date.strftime("%A") == "Sunday" || date.strftime("%A") ==  "Saturday")? true : false
    return bool
  end
end
