# frozen_string_literal: true

module Transport
  class DriverProfileBlueprint < Blueprinter::Base
    fields :id,
           :confirmed,
           :license_number,
           # Profile fields Delegated
           :full_name,
           :first_name,
           :middle_initial,
           :sex,
           :birthday,
           :email
  end
end
