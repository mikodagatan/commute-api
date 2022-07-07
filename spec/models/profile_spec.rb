# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: profiles
#
#  id             :uuid             not null, primary key
#  birthday       :datetime
#  first_name     :string
#  last_name      :string
#  middle_initial :string
#  sex            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
