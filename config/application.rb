# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module CommuteAPI
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true
    config.autoload_paths << "#{root}/lib/"
    config.i18n.available_locales = [:en, 'es-mx', :ja, :tl]
  end
end
