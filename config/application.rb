require File.expand_path('../boot', __FILE__)

#require 'rails/all'

require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module Timestamps
  class Application < Rails::Application
    config.time_zone = 'Berlin'
    #config.i18n.default_locale = :de
    config.encoding = "utf-8"
    config.filter_parameters += [:password, :password_confirmation]

    config.autoload_paths += Dir["#{config.root}/lib/**/"]  # include all subdirectories

    # Enable the asset pipeline
    config.assets.enabled = true
    config.assets.paths << "#{Rails.root}/app/assets/fonts"
    config.assets.version = '1.0'

    config.generators do |g|
      g.template_engine :haml
    end

  end
end
