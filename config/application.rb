require File.expand_path('../boot', __FILE__)
require 'rails/all'

Bundler.require(*Rails.groups)

module Timetracker
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)
    config.time_zone = 'Berlin'

    config.generators do |g|
      g.template_engine :haml
      g.test_framework      :rspec, fixture: true
      g.fixture_replacement :fabrication
    end
  end
end
