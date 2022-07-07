# frozen_string_literal: true

class ProfileBlueprint < Blueprinter::Base
  field :id
  field :user_id
  field :birthday
  field :full_name
  field :first_name
  field :middle_initial
  field :last_name
  field :sex
end
