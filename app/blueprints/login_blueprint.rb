# frozen_string_literal: true

class LoginBlueprint < Blueprinter::Base
  field :id
  field :email

  identifier :exp do |_user, options|
    options[:exp]
  end

  identifier :token do |_user, options|
    options[:token]
  end

  association :profile, blueprint: ProfileBlueprint, view: :normal
end
