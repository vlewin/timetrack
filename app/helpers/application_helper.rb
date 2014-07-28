module ApplicationHelper

end

# form_helper.rb
module ActionView
  module Helpers
    module FormHelper
      def time_field(object_name, method, options = {})
        content_tag(:div, text_field(object_name, method, options) + content_tag(:button, content_tag(:i, '', :class=>"fa fa-clock-o"), :class => "btn now"), :class=>"input-append")
      end

      def duration
        if Timetrack.balance(current_user)[:negative]
          css_class = "negative"
          value = "- #{Timetrack.balance(current_user)[:value]}"
        else
          css_class = ""
          value = Timetrack.balance(current_user)[:value]
        end

        content_tag(:b, value, :class => css_class)
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
  def negative?
    self.to_s.match('-').present?
  end
end

class Date
  def weekend?
    (self.strftime("%A") == "Sunday" || self.strftime("%A") ==  "Saturday")? true : false
  end
end
