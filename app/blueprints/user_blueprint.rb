class UserBlueprint < Blueprinter::Base
  fields :email

  view :normal do
    association :profile, blueprint: ProfileBlueprint
  end
end
