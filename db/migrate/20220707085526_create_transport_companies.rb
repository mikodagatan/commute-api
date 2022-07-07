class CreateTransportCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :transport_companies, id: :uuid do |t|
      t.references :owner, index: true,  
                           type: :uuid,
                           foreign_key: { to_table: :users }
      t.string :name
      t.timestamps
    end
  end
end
