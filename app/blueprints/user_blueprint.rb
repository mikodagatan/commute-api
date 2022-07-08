# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  field :id
  field :email

  view :normal do
    association :profile, blueprint: ProfileBlueprint, default: {}
  end
end
