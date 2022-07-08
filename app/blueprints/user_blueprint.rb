# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  field :id
  field :email
  field :full_name
  field :first_name
  field :last_name
  field :middle_initial
  field :sex
  field :birthday
end
