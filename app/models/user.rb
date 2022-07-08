# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_one :profile, dependent: :destroy
  has_one :owned_company, dependent: :destroy,
                          class_name: 'Transport::Company',
                          foreign_key: :owner_id,
                          inverse_of: :owner
  has_one :driver_profile, dependent: :destroy,
                           class_name: 'Transport::DriverProfile'
  has_one :employee_company, through: :driver_profile,
                             class_name: 'Transport::Company'

  has_one_attached :photo

  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 },
                       if: -> { new_record? || password.present? }

  delegate :full_name,
           :first_name,
           :last_name,
           :middle_initial,
           :sex,
           :birthday,
           to: :profile, allow_nil: true

  delegate :license_number, to: :driver_profile, allow_nil: true
end

# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
