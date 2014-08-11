module ApplicationHelper
  def balance
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

# form_helper.rb
module ActionView
  module Helpers
    module FormHelper
      def time_select(object_name, method, options = {}, html_options = {})
        object = options[:object]
        default_options = {
          start_hour:   6,
          end_hour:     20,
          start_minute: 10,
          minute_step:  5
        }

        options.merge!(default_options)

        if method == :finish
          # options[:start_hour] = object.start.hour
          # options[:start_minute] = object.start.min
        end

        Tags::TimeSelect.new(object_name, method, self, options, html_options).render
      end
    end
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
