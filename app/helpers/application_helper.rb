module ApplicationHelper

end

# form_helper.rb
module ActionView
  module Helpers
    module FormHelper
      def time_field(object_name, method, options = {})
        content_tag(:div, text_field(object_name, method, options) + content_tag(:button, content_tag(:i, '', :class=>"icon-time"), :class => "btn now"), :class=>"input-append")
      end

      def duration
        balance = Timetrack.balance(current_user).to_f

        if balance.negative?
          content_tag(:b, balance.ftime, :class => "red")
        else
          content_tag(:b, balance.ftime)
        end
      end

    end
  end
end

class ActionView::Helpers::FormBuilder
  def time_field(method, options={})
    @template.time_field(@object_name, method, objectify_options(options))
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
  def positive?
    self >= 0
  end

  def negative?
    self < 0
  end
end


# FIXME: refactor
class Float
  def ftime
    hh = (self/3600).to_i;
    mm = ((self/3600 - hh) * 60).to_i

    if hh.negative?
      "- #{hh.abs} hour(s) #{mm.abs} minutes"
    else
      "#{hh} hour(s) #{mm} minutes"
    end
  end
end

class Date
  def weekend?
    (self.strftime("%A") == "Sunday" || self.strftime("%A") ==  "Saturday")? true : false
  end

  def today?
    (self == Date.today)? true : false
  end
end
