class CreateTransportDriverProfiles < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'uuid-ossp'
    create_table :transport_driver_profiles do |t|
      t.references :user, index: true,
                          type: :uuid,
                          foreign_key: { to_table: :users }
      t.references :company, index: true,
                             type: :uuid,
                             foreign_key: { to_table: :transport_companies }
      t.string :license_number
      t.boolean :confirmed, default: false
      t.timestamps
    end
  end
end
