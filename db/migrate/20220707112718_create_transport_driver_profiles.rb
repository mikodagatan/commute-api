class CreateTransportDriverProfiles < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'uuid-ossp'
    create_table :transport_driver_profiles, id: :uuid do |t|
      t.references :user, type: :uuid,
                          foreign_key: { to_table: :users },
                          index: { unique: true }
      t.references :company, index: true,
                             type: :uuid,
                             foreign_key: { to_table: :transport_companies }
      t.string :license_number
      t.boolean :confirmed, default: false
      t.timestamps
    end

    add_index :transport_driver_profiles, [:user_id, :id], unique: true
  end
end
