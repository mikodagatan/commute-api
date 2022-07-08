# frozen_string_literal: true

module Transport
  class DriverProfile < ApplicationRecord
    belongs_to :user
    belongs_to :company, optional: true,
                         class_name: 'Transport::Company'

    has_one_attached :photo
    has_one_attached :license_image

    validates :user_id, uniqueness: true

    delegate :full_name,
             :first_name,
             :last_name,
             :middle_initial,
             :sex,
             :birthday,
             :email,
             to: :user, allow_nil: true
  end
end

# == Schema Information
#
# Table name: transport_driver_profiles
#
#  id             :uuid             not null, primary key
#  confirmed      :boolean          default(FALSE)
#  license_number :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  company_id     :uuid
#  user_id        :uuid
#
# Indexes
#
#  index_transport_driver_profiles_on_company_id      (company_id)
#  index_transport_driver_profiles_on_user_id         (user_id) UNIQUE
#  index_transport_driver_profiles_on_user_id_and_id  (user_id,id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => transport_companies.id)
#  fk_rails_...  (user_id => users.id)
#
