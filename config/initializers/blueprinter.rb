# frozen_string_literal: true

Blueprinter.configure do |config|
  config.datetime_format = ->(datetime) { Formats::DateTime.default(datetime) }
  config.sort_fields_by = :definition
  config.field_default = 'N/A'
  config.association_default = {}
end
