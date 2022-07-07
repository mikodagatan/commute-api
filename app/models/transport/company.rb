# frozen_string_literal: true

module Transport
  class Company < ApplicationRecord
    belongs_to :owner, class_name: 'User'

    validates :name, presence: true,
                     length: { minimum: 5 }
  end
end

# == Schema Information
#
# Table name: transport_companies
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :uuid
#
# Indexes
#
#  index_transport_companies_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
