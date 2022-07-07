# frozen_string_literal: true

module Transport
  class DriverBlueprint < Blueprinter::Base
    field :id
    field :name
    field :confirmed
    field :license_number
  end
end
