# frozen_string_literal: true

class ProfileBlueprint < Blueprinter::Base
  field :id
  field :birthday
  field :first_name
  field :middle_initial
  field :last_name
  field :sex

  field :full_name do |user|
    "#{user.first_name} #{user.middle_initial} #{user.last_name}"
  end
end
