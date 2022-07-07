# frozen_string_literal: true

Blueprinter.configure do |config|
  config.datetime_format = ->(datetime) { Formats::DateTime.default(datetime) }
end
