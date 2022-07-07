# frozen_string_literal: true

module Formats
  class DateTime
    class << self
      # NOTE: Code to look at.
      FORMATS = {
        default: '%d-%m-%Y',
        jwt: '%m-%d-%Y %H:%M',
        long: '%b %d, %Y',
        longer: '%B %d, %Y'
      }.freeze

      # NOTE: creates methods for the key-value pairs in FORMATS constant.
      # e.g. def default(datetime)
      FORMATS.each do |key, value|
        define_method(:"#{key}") do |datetime = nil|
          return value unless datetime

          datetime&.to_date&.strftime(value)
        end
      end
    end
  end
end
