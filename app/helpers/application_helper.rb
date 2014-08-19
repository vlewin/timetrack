module ApplicationHelper
end

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

        # if method == :finish
        #   options[:start_hour] = object.start.hour
        #   options[:start_minute] = object.start.min
        # end

        Tags::TimeSelect.new(object_name, method, self, options, html_options).render
      end
    end
  end
end

