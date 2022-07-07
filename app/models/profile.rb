# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  validates :birthday, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :sex, presence: true,
                  inclusion: %w[male female]
  validates :middle_initial, length: { maximum: 1 },
                             if: -> { middle_initial.present? }

  after_commit :upcase_initials

  def full_name
    return nil unless presence # Required for delegation

    "#{first_name} #{middle_initial}. #{last_name}"
  end

  private

  def upcase_initials
    return if Regularity.new.start_with(1, :uppercase).match?(middle_initial)

    update(middle_initial: middle_initial.upcase)
  end
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
#  user_id        :uuid
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
