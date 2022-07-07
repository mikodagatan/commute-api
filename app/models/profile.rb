# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  SEX_OPTIONS = %w[male female].freeze

  validates :birthday, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :sex, presence: true,
                  inclusion: %w[male female]
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
