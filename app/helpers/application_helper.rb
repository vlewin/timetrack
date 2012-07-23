module ApplicationHelper

end

class Date
  def weekend?
    (self.strftime("%A") == "Sunday" || self.strftime("%A") == "Saturday")? true : false
  end
end
