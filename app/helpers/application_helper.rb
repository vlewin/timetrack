module ApplicationHelper

end

class Date
  def weekend?
    (self.strftime("%A") == "Sunday" || self.strftime("%A") == "Saturday")? true : false
  end
end

# form_helper.rb
module ActionView
  module Helpers
    module FormHelper
      def time_field(object_name, method, options = {})
        content_tag(:div, text_field(object_name, method, options) + content_tag(:button, content_tag(:i, '', :class=>"icon-time"), :class => "btn now"), :class=>"input-append")
      end
    end
  end
end

class ActionView::Helpers::FormBuilder
  def time_field(method, options={})
    @template.time_field(@object_name, method, objectify_options(options))
  end
end
